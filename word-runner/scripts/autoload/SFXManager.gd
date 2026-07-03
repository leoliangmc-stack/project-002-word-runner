extends Node
## Plays short one-shot sound effects (never queued/overlap-blocked, unlike voice).
## See ASSET.md assets/audio/sfx/ and GAME_RULES.md sections 16-17.

var _player: AudioStreamPlayer

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	add_child(_player)

func play(sfx_path: String) -> void:
	if not ResourceLoader.exists(sfx_path):
		push_warning("SFXManager: missing sfx '%s'" % sfx_path)
		return
	_player.stream = load(sfx_path)
	_player.volume_db = linear_to_db(clampf(SaveManager.sfx_volume, 0.0, 1.0))
	_player.play()
