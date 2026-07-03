extends Node
## Persists local progress (high score). See GAME_RULES.md section 10.

const SAVE_PATH := "user://save.json"

var high_score: int = 0
var music_volume: float = 1.0
var sfx_volume: float = 1.0
var voice_volume: float = 1.0

func _ready() -> void:
	load_data()

func load_data() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) == TYPE_DICTIONARY:
		high_score = parsed.get("high_score", 0)
		music_volume = parsed.get("music_volume", 1.0)
		sfx_volume = parsed.get("sfx_volume", 1.0)
		voice_volume = parsed.get("voice_volume", 1.0)

func save_data() -> void:
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify({
		"high_score": high_score,
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"voice_volume": voice_volume,
	}))

## Returns true if this score beat the saved high score.
func report_score(score: int) -> bool:
	if score > high_score:
		high_score = score
		save_data()
		return true
	return false

func set_music_volume(value: float) -> void:
	music_volume = clampf(value, 0.0, 1.0)
	save_data()

func set_sfx_volume(value: float) -> void:
	sfx_volume = clampf(value, 0.0, 1.0)
	save_data()

func set_voice_volume(value: float) -> void:
	voice_volume = clampf(value, 0.0, 1.0)
	save_data()
