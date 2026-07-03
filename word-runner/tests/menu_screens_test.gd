extends Node
## Smoke test for MainMenu/Settings/GameOver wiring. Run as main scene:
## godot --headless --path . res://tests/MenuScreensTestScene.tscn
## Buttons are never pressed here (that would trigger a real scene swap on
## the currently-running scene); only _ready()-driven state is checked.

func _ready() -> void:
	SaveManager.high_score = 42
	SaveManager.music_volume = 0.6
	SaveManager.sfx_volume = 0.7
	SaveManager.voice_volume = 0.8
	GameManager.score = 5

	var menu = load("res://scenes/menu/MainMenu.tscn").instantiate()
	add_child(menu)
	assert(menu.high_score_label.text == "Best: 42", "MainMenu should show saved high score, got '%s'" % menu.high_score_label.text)
	menu.queue_free()

	var settings = load("res://scenes/menu/Settings.tscn").instantiate()
	add_child(settings)
	assert(is_equal_approx(settings.music_slider.value, 0.6), "music slider should reflect saved value")
	assert(is_equal_approx(settings.sfx_slider.value, 0.7), "sfx slider should reflect saved value")
	assert(is_equal_approx(settings.voice_slider.value, 0.8), "voice slider should reflect saved value")
	settings.voice_slider.value = 0.3
	settings.voice_slider.value_changed.emit(0.3)
	assert(is_equal_approx(SaveManager.voice_volume, 0.3), "adjusting slider should update SaveManager, got %f" % SaveManager.voice_volume)
	settings.queue_free()

	var game_over = load("res://scenes/menu/GameOver.tscn").instantiate()
	add_child(game_over)
	assert(game_over.score_label.text == "Score: 5", "GameOver should show current score, got '%s'" % game_over.score_label.text)
	assert(game_over.best_label.text == "Best: 42", "GameOver should show saved high score, got '%s'" % game_over.best_label.text)
	game_over.queue_free()

	print("Menu screens smoke test: PASS")
	get_tree().quit()
