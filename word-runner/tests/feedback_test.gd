extends Node2D
## Smoke test for correct/wrong feedback (animations + sfx hook). Run as main scene:
## godot --headless --path . res://tests/FeedbackTestScene.tscn

const PlayerScene := preload("res://scenes/player/Player.tscn")

func _ready() -> void:
	var player = PlayerScene.instantiate()
	add_child(player)

	player.flash_correct()
	player.play_wrong()

	SFXManager.play("res://assets/audio/sfx/correct.wav")
	SFXManager.play("res://assets/audio/sfx/wrong.wav")

	await get_tree().create_timer(0.6).timeout

	assert(player.scale.is_equal_approx(Vector2.ONE), "correct feedback should never touch scale (no bounce)")
	assert(player.visual.modulate.is_equal_approx(Color.WHITE), "visual tint should fade back to normal after flash")

	print("Feedback smoke test: PASS")
	get_tree().quit()
