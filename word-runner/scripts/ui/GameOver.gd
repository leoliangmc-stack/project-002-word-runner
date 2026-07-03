extends Control

@onready var score_label: Label = $ScoreLabel
@onready var best_label: Label = $BestLabel
@onready var play_again_button: Button = $Buttons/PlayAgainButton
@onready var home_button: Button = $Buttons/HomeButton

func _ready() -> void:
	score_label.text = "Score: %d" % GameManager.score
	best_label.text = "Best: %d" % SaveManager.high_score
	play_again_button.pressed.connect(_on_play_again_pressed)
	home_button.pressed.connect(_on_home_pressed)

func _on_play_again_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/Game.tscn")

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/MainMenu.tscn")
