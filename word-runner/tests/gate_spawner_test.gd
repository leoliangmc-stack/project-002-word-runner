extends Node2D
## Smoke test for GateSpawner. Run as main scene:
## godot --headless --path . res://tests/GateSpawnerTestScene.tscn

const GateSpawnerScript := preload("res://scripts/gate/GateSpawner.gd")

func _ready() -> void:
	var spawner = GateSpawnerScript.new()
	add_child(spawner)
	var lanes: Array[float] = [200.0, 400.0, 600.0]
	spawner.lane_positions = lanes

	var target: Dictionary = WordManager.pick_target("Animals")
	assert(not target.is_empty(), "no target picked")
	spawner._spawn_gates(target)

	assert(spawner.get_child_count() == 3, "expected 3 gates, got %d" % spawner.get_child_count())

	var correct_count := 0
	for gate in spawner.get_children():
		assert(gate.label.text == gate.word_data["word"], "gate label should show its word")
		if gate.is_correct:
			correct_count += 1
			assert(gate.word_data["id"] == target["id"], "correct gate should match target id")
	assert(correct_count == 1, "expected exactly 1 correct gate, got %d" % correct_count)

	print("GateSpawner smoke test: PASS")
	get_tree().quit()
