extends Node
## Smoke test for HUD contrast fix + heart-based lives display. Run as main scene:
## godot --headless --path . res://tests/HudTestScene.tscn

func _ready() -> void:
	var game = load("res://scenes/game/Game.tscn").instantiate()
	add_child(game)
	await get_tree().process_frame

	game._on_lives_changed(3)
	assert(game.lives_label.text == "♥♥♥", "expected 3 hearts, got '%s'" % game.lives_label.text)

	game._on_lives_changed(1)
	assert(game.lives_label.text == "♥", "expected 1 heart, got '%s'" % game.lives_label.text)

	game._on_lives_changed(0)
	assert(game.lives_label.text == "", "expected no hearts at 0 lives, got '%s'" % game.lives_label.text)

	var red := Color(0.9568627, 0.2588235, 0.2117647, 1)
	var font_color: Color = game.lives_label.get_theme_color("font_color")
	assert(font_color.is_equal_approx(red), "lives label should be red, got %s" % font_color)

	var label_dark := Color(0.1294118, 0.1294118, 0.1294118, 1)
	var score_color: Color = game.score_label.get_theme_color("font_color")
	assert(score_color.is_equal_approx(label_dark), "score label should use dark theme font color, got %s" % score_color)

	print("HUD smoke test: PASS")
	get_tree().quit()
