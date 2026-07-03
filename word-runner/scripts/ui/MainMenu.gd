extends Control

@onready var high_score_label: Label = $HighScoreLabel
@onready var play_button: Button = $Buttons/PlayButton
@onready var settings_button: Button = $Buttons/SettingsButton
@onready var exit_button: Button = $Buttons/ExitButton

func _ready() -> void:
	high_score_label.text = "Best: %d" % SaveManager.high_score
	play_button.pressed.connect(_on_play_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/Game.tscn")

func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/Settings.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
