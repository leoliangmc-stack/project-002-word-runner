extends Node2D

const BACKGROUND_ART_PATH := "res://assets/backgrounds/grass.png"

@onready var player: Node2D = $Player
@onready var gate_spawner: Node2D = $GateSpawner
@onready var score_label: Label = $HUD/ScoreLabel
@onready var lives_display: Control = $HUD/LivesDisplay
@onready var camera: Camera2D = $Camera2D
@onready var flash_overlay: ColorRect = $FlashOverlay
@onready var background_art: TextureRect = $BackgroundArt

func _ready() -> void:
	_load_background()
	score_label.pivot_offset = score_label.size / 2.0
	lives_display.pivot_offset = lives_display.size / 2.0

	GameManager.reset()
	GameManager.score_changed.connect(_on_score_changed)
	GameManager.lives_changed.connect(_on_lives_changed)
	GameManager.game_over.connect(_on_game_over)
	_on_score_changed(GameManager.score)
	_on_lives_changed(GameManager.lives)

	gate_spawner.player = player
	gate_spawner.reach_y = player.position.y
	gate_spawner.target_announced.connect(_on_target_announced)
	gate_spawner.round_resolved.connect(_on_round_resolved)
	gate_spawner.start(player.lane_positions)

## Uses the art file when present, otherwise keeps the placeholder color block.
## See ASSET.md: gameplay must never stop because of missing art.
func _load_background() -> void:
	if ResourceLoader.exists(BACKGROUND_ART_PATH):
		background_art.texture = load(BACKGROUND_ART_PATH)
		background_art.show()

func _on_target_announced(word_data: Dictionary) -> void:
	AudioManager.play_word(word_data)

func _on_round_resolved(correct: bool, _word_data: Dictionary) -> void:
	if correct:
		player.flash_correct()
		SFXManager.play("res://assets/audio/sfx/correct.wav")
		_flash(Color(0.3, 0.8, 0.3, 0.35))
	else:
		player.play_wrong()
		SFXManager.play("res://assets/audio/sfx/wrong.wav")
		_flash(Color(0.9, 0.2, 0.2, 0.35))
		_shake_camera(8.0, 0.25)

func _flash(color: Color) -> void:
	flash_overlay.color = color
	var t := create_tween()
	t.tween_property(flash_overlay, "color:a", 0.0, 0.4)

func _shake_camera(strength: float, duration: float) -> void:
	var steps := 6
	var step_time := duration / steps
	var t := create_tween()
	for i in range(steps):
		var offset := Vector2(randf_range(-strength, strength), randf_range(-strength, strength))
		t.tween_property(camera, "offset", offset, step_time)
	t.tween_property(camera, "offset", Vector2.ZERO, step_time)

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Score: %d" % new_score
	score_label.scale = Vector2(1.4, 1.4)
	var t := create_tween()
	t.tween_property(score_label, "scale", Vector2.ONE, 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func _on_lives_changed(new_lives: int) -> void:
	lives_display.set_lives(new_lives)
	var base_x := lives_display.position.x
	var t := create_tween()
	for i in range(4):
		var offset := 8.0 if i % 2 == 0 else -8.0
		t.tween_property(lives_display, "position:x", base_x + offset, 0.05)
	t.tween_property(lives_display, "position:x", base_x, 0.05)

func _on_game_over() -> void:
	gate_spawner.stop()
	SaveManager.report_score(GameManager.score)
	get_tree().change_scene_to_file("res://scenes/menu/GameOver.tscn")
