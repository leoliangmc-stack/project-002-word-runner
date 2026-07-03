extends Node
## Smoke test for SaveManager persistence. Run as main scene:
## godot --headless --path . res://tests/SaveManagerTestScene.tscn

const SaveManagerScript := preload("res://scripts/autoload/SaveManager.gd")

func _ready() -> void:
	if FileAccess.file_exists(SaveManagerScript.SAVE_PATH):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(SaveManagerScript.SAVE_PATH))

	var sm = SaveManagerScript.new()
	add_child(sm)
	assert(sm.high_score == 0, "expected fresh high_score of 0, got %d" % sm.high_score)

	assert(not sm.report_score(0), "score of 0 should not beat high_score of 0")
	assert(sm.report_score(10), "score of 10 should beat high_score of 0")
	assert(sm.high_score == 10, "expected high_score 10, got %d" % sm.high_score)
	assert(not sm.report_score(5), "score of 5 should not beat high_score of 10")
	assert(sm.high_score == 10, "high_score should remain 10, got %d" % sm.high_score)

	var sm2 = SaveManagerScript.new()
	add_child(sm2)
	sm2.load_data()
	assert(sm2.high_score == 10, "reloaded high_score should be 10, got %d" % sm2.high_score)

	DirAccess.remove_absolute(ProjectSettings.globalize_path(SaveManagerScript.SAVE_PATH))

	print("SaveManager smoke test: PASS")
	get_tree().quit()
