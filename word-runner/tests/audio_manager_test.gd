extends Node
## Smoke test for AudioManager. Run as main scene:
## godot --headless --path . res://tests/AudioManagerTestScene.tscn

const AudioManagerScript := preload("res://scripts/autoload/AudioManager.gd")

func _ready() -> void:
	var am = AudioManagerScript.new()
	add_child(am)

	var missing_fired := [false]
	var spoken_fired := [false]
	am.audio_missing.connect(func(_w): missing_fired[0] = true)
	am.word_spoken.connect(func(_w): spoken_fired[0] = true)

	am.play_word({"word": "Dog", "audio": "res://assets/audio/voice/dog.mp3"})

	assert(missing_fired[0], "expected audio_missing to fire when audio file is absent")
	assert(spoken_fired[0], "expected word_spoken to fire even when audio is missing")
	assert(not am._playing, "queue should drain immediately when audio is missing")

	print("AudioManager smoke test: PASS")
	get_tree().quit()
