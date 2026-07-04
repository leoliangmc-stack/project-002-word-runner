extends Node
## Smoke test for HUD contrast fix + vector-drawn heart lives display. Run as main scene:
## godot --headless --path . res://tests/HudTestScene.tscn

func _ready() -> void:
	var game = load("res://scenes/game/Game.tscn").instantiate()
	add_child(game)
	await get_tree().process_frame

	game._on_lives_changed(3)
	assert(game.lives_display.lives == 3, "expected 3 lives, got %d" % game.lives_display.lives)

	game._on_lives_changed(1)
	assert(game.lives_display.lives == 1, "expected 1 life, got %d" % game.lives_display.lives)

	game._on_lives_changed(0)
	assert(game.lives_display.lives == 0, "expected 0 lives, got %d" % game.lives_display.lives)

	var red := Color(0.9568627, 0.2588235, 0.2117647, 1)
	assert(game.lives_display.heart_color.is_equal_approx(red), "hearts should be red, got %s" % game.lives_display.heart_color)

	var label_dark := Color(0.1294118, 0.1294118, 0.1294118, 1)
	var score_color: Color = game.score_label.get_theme_color("font_color")
	assert(score_color.is_equal_approx(label_dark), "score label should use dark theme font color, got %s" % score_color)

	print("HUD smoke test: PASS")
	get_tree().quit()
