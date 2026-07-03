extends Node
## Plays target-word pronunciation audio, queued so playback never overlaps.
## See GAME_RULES.md section 14 and ASSET.md placeholder policy.

signal word_spoken(word_data: Dictionary)
signal audio_missing(word_data: Dictionary)

var _player: AudioStreamPlayer
var _queue: Array = []
var _playing := false

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	add_child(_player)
	_player.finished.connect(_play_next)

func play_word(word_data: Dictionary) -> void:
	_queue.append(word_data)
	if not _playing:
		_play_next()

func _play_next() -> void:
	if _queue.is_empty():
		_playing = false
		return
	_playing = true
	var word_data: Dictionary = _queue.pop_front()
	var path: String = word_data.get("audio", "")
	if path != "" and ResourceLoader.exists(path):
		_player.stream = load(path)
		_player.volume_db = linear_to_db(clampf(SaveManager.voice_volume, 0.0, 1.0))
		_player.play()
		word_spoken.emit(word_data)
	else:
		push_warning("AudioManager: missing audio for '%s' (%s)" % [word_data.get("word", "?"), path])
		audio_missing.emit(word_data)
		word_spoken.emit(word_data)
		_play_next()
