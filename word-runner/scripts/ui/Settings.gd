extends Control

@onready var music_slider: HSlider = $Sliders/MusicRow/MusicSlider
@onready var sfx_slider: HSlider = $Sliders/SFXRow/SFXSlider
@onready var voice_slider: HSlider = $Sliders/VoiceRow/VoiceSlider
@onready var back_button: Button = $BackButton

func _ready() -> void:
	music_slider.value = SaveManager.music_volume
	sfx_slider.value = SaveManager.sfx_volume
	voice_slider.value = SaveManager.voice_volume

	music_slider.value_changed.connect(SaveManager.set_music_volume)
	sfx_slider.value_changed.connect(SaveManager.set_sfx_volume)
	voice_slider.value_changed.connect(SaveManager.set_voice_volume)
	back_button.pressed.connect(_on_back_pressed)

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/MainMenu.tscn")
