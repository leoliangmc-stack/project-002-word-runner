extends SceneTree
## Headless smoke test for WordManager. Run with:
## godot --headless --script res://tests/test_word_manager.gd

func _init() -> void:
	var wm = load("res://scripts/autoload/WordManager.gd").new()
	wm.load_words()

	assert(wm.words.size() == 100, "expected 100 words, got %d" % wm.words.size())

	var cats = wm.get_categories()
	for required in ["Animals", "Food", "Colors"]:
		assert(cats.has(required), "missing category %s" % required)

	for i in range(20):
		var target = wm.pick_target("Animals")
		assert(target.has("word"), "pick_target returned empty")
		var distractors = wm.pick_distractors(target, 2)
		assert(distractors.size() == 2, "expected 2 distractors, got %d" % distractors.size())
		for d in distractors:
			assert(d["id"] != target["id"], "distractor equals target")
			assert(d["category"] == target["category"], "distractor category mismatch")

	print("WordManager smoke test: PASS")
	quit()
