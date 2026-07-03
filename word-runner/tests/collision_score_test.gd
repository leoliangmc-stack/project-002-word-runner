extends Node2D
## Smoke test for lane-based collision resolution + score/lives. Run as main scene:
## godot --headless --path . res://tests/CollisionScoreTestScene.tscn

const GateSpawnerScript := preload("res://scripts/gate/GateSpawner.gd")
const PlayerScene := preload("res://scenes/player/Player.tscn")

func _ready() -> void:
	GameManager.reset()

	var player = PlayerScene.instantiate()
	add_child(player)
	player.lane_positions = player.compute_lane_positions(900.0)

	var spawner = GateSpawnerScript.new()
	add_child(spawner)
	spawner.lane_positions = player.lane_positions
	spawner.player = player

	var target: Dictionary = WordManager.pick_target("Animals")
	spawner._spawn_gates(target)

	var correct_lane := _find_lane(spawner, true)
	assert(correct_lane != -1, "no correct gate found")

	player.move_to_lane(correct_lane)
	spawner._resolve_round()
	assert(GameManager.score == 1, "expected score 1, got %d" % GameManager.score)
	assert(GameManager.lives == 3, "expected lives unchanged at 3, got %d" % GameManager.lives)

	spawner._clear_gates()
	var target2: Dictionary = WordManager.pick_target("Animals")
	spawner._spawn_gates(target2)
	var wrong_lane := _find_lane(spawner, false)
	assert(wrong_lane != -1, "no wrong gate found")

	player.move_to_lane(wrong_lane)
	spawner._resolve_round()
	assert(GameManager.lives == 2, "expected lives 2 after wrong answer, got %d" % GameManager.lives)

	var game_over_fired := [false]
	GameManager.game_over.connect(func(): game_over_fired[0] = true)
	GameManager.lose_life(2)
	assert(GameManager.lives == 0, "expected lives 0, got %d" % GameManager.lives)
	assert(game_over_fired[0], "expected game_over signal to fire at 0 lives")

	print("Collision/Score/Lives smoke test: PASS")
	get_tree().quit()

func _find_lane(spawner, want_correct: bool) -> int:
	for i in range(spawner._active_gates.size()):
		if spawner._active_gates[i].is_correct == want_correct:
			return i
	return -1
