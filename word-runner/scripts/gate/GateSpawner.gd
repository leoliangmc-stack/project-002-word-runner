extends Node2D
## Spawns a wave of word gates each round. See GAME_RULES.md sections 4, 5, 7.

signal target_announced(word: Dictionary)
signal round_resolved(correct: bool, word_data: Dictionary)
signal round_finished

const GateScene := preload("res://scenes/gate/Gate.tscn")

@export var category: String = "Animals"
@export var spawn_y: float = -60.0
@export var reach_y: float = 550.0
@export var reach_time: float = 2.5
@export var gate_delay: float = 0.5
@export var next_round_delay: float = 0.5

## Endless-mode difficulty scaling. See GAME_RULES.md section 8: gradual, never sudden.
const BASE_REACH_TIME := 2.5
const MIN_REACH_TIME := 1.0
const REACH_TIME_STEP := 0.15
const ROUNDS_PER_LEVEL := 5

var player: Node = null
var lane_positions: Array[float] = []
var round_count: int = 0
var _running := false
var _active_gates: Array = []

func start(lanes: Array[float]) -> void:
	lane_positions = lanes
	_running = true
	_run_loop()

func stop() -> void:
	_running = false
	_clear_gates()

func _run_loop() -> void:
	while _running and not GameManager.is_game_over:
		await _play_round()

func _play_round() -> void:
	var target: Dictionary = WordManager.pick_target(category)
	if target.is_empty():
		push_error("GateSpawner: no words available for category '%s'" % category)
		_running = false
		return

	round_count += 1
	_apply_difficulty()
	target_announced.emit(target)

	await get_tree().create_timer(gate_delay).timeout
	if not _running:
		return
	_spawn_gates(target)

	await get_tree().create_timer(reach_time).timeout
	if not _running:
		return
	_resolve_round()
	_clear_gates()
	round_finished.emit()

	# _resolve_round() may trigger game over, which stops the loop and
	# frees this node's whole scene branch (change_scene_to_file). Awaiting
	# another timer on a soon-to-be-freed node crashes when it fires, so bail
	# out immediately instead of scheduling more work.
	if not _running:
		return
	await get_tree().create_timer(next_round_delay).timeout

## The player always sits at a fixed y; gates always arrive at that same y
## together, so "collision" is simply: which lane is the player in right now.
func _resolve_round() -> void:
	if player == null:
		return
	var lane: int = player.current_lane
	if lane < 0 or lane >= _active_gates.size():
		return
	var gate = _active_gates[lane]
	if not is_instance_valid(gate):
		return
	if gate.is_correct:
		GameManager.add_score(1)
	else:
		GameManager.lose_life(1)
	round_resolved.emit(gate.is_correct, gate.word_data)

func _apply_difficulty() -> void:
	var level: int = (round_count - 1) / ROUNDS_PER_LEVEL
	reach_time = maxf(MIN_REACH_TIME, BASE_REACH_TIME - level * REACH_TIME_STEP)

func _spawn_gates(target: Dictionary) -> void:
	var distractors: Array = WordManager.pick_distractors(target, lane_positions.size() - 1)
	var pool: Array = distractors.duplicate()
	pool.append(target)
	pool.shuffle()

	for i in range(lane_positions.size()):
		var gate = GateScene.instantiate()
		add_child(gate)
		gate.position = Vector2(lane_positions[i], spawn_y)
		var word_data: Dictionary = pool[i]
		gate.setup(word_data, word_data["id"] == target["id"])
		gate.move_to(reach_y, reach_time)
		_active_gates.append(gate)

func _clear_gates() -> void:
	for gate in _active_gates:
		if is_instance_valid(gate):
			gate.queue_free()
	_active_gates.clear()
