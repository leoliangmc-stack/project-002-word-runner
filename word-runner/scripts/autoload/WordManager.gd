extends Node
## Loads and serves the vocabulary database (data/words.json).
## See WORD_DATABASE.md for the data spec and selection rules.

const WORDS_PATH := "res://data/words.json"
const HISTORY_SIZE := 10

var words: Array = []
var _recent_ids: Array = []

func _ready() -> void:
	load_words()

func load_words() -> void:
	words.clear()
	if not FileAccess.file_exists(WORDS_PATH):
		push_error("WordManager: missing %s" % WORDS_PATH)
		return

	var file := FileAccess.open(WORDS_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	if typeof(parsed) != TYPE_DICTIONARY or not parsed.has("words"):
		push_error("WordManager: invalid words.json format")
		return

	var seen_ids := {}
	var seen_words := {}
	for entry in parsed["words"]:
		if not _is_valid(entry, seen_ids, seen_words):
			continue
		seen_ids[entry["id"]] = true
		seen_words[entry["word"]] = true
		words.append(entry)

func _is_valid(entry: Dictionary, seen_ids: Dictionary, seen_words: Dictionary) -> bool:
	for field in ["id", "word", "category", "difficulty", "image", "audio", "enabled"]:
		if not entry.has(field):
			push_warning("WordManager: word entry missing field '%s': %s" % [field, entry])
			return false
	if seen_ids.has(entry["id"]):
		push_warning("WordManager: duplicate id %s" % entry["id"])
		return false
	if seen_words.has(entry["word"]):
		push_warning("WordManager: duplicate word '%s'" % entry["word"])
		return false
	return true

func get_categories() -> Array:
	var cats := {}
	for w in words:
		cats[w["category"]] = true
	return cats.keys()

func get_enabled_words(category: String = "") -> Array:
	var result := []
	for w in words:
		if not w["enabled"]:
			continue
		if category != "" and w["category"] != category:
			continue
		result.append(w)
	return result

## Picks a random target word, avoiding the last HISTORY_SIZE picks when possible.
func pick_target(category: String = "") -> Dictionary:
	var pool := get_enabled_words(category)
	if pool.is_empty():
		return {}

	var fresh_pool := pool.filter(func(w): return not _recent_ids.has(w["id"]))
	var choices := fresh_pool if not fresh_pool.is_empty() else pool

	var target: Dictionary = choices[randi() % choices.size()]
	_recent_ids.append(target["id"])
	if _recent_ids.size() > HISTORY_SIZE:
		_recent_ids.pop_front()
	return target

## Picks `count` distractor words sharing category/difficulty with the target.
func pick_distractors(target: Dictionary, count: int) -> Array:
	var pool := get_enabled_words(target["category"])
	pool = pool.filter(func(w): return w["id"] != target["id"])

	var same_difficulty = pool.filter(func(w): return w["difficulty"] == target["difficulty"])
	var candidates = same_difficulty if same_difficulty.size() >= count else pool

	candidates = candidates.duplicate()
	candidates.shuffle()
	return candidates.slice(0, min(count, candidates.size()))
