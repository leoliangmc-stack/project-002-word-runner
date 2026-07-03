extends Node2D
## Smoke test for gradual difficulty scaling. Run as main scene:
## godot --headless --path . res://tests/DifficultyTestScene.tscn

const GateSpawnerScript := preload("res://scripts/gate/GateSpawner.gd")

func _ready() -> void:
	var spawner = GateSpawnerScript.new()
	add_child(spawner)

	spawner.round_count = 1
	spawner._apply_difficulty()
	assert(is_equal_approx(spawner.reach_time, 2.5), "round 1 should be base reach_time, got %f" % spawner.reach_time)

	spawner.round_count = 5
	spawner._apply_difficulty()
	assert(is_equal_approx(spawner.reach_time, 2.5), "round 5 still level 0, got %f" % spawner.reach_time)

	spawner.round_count = 6
	spawner._apply_difficulty()
	assert(is_equal_approx(spawner.reach_time, 2.35), "round 6 should step down once, got %f" % spawner.reach_time)

	spawner.round_count = 11
	spawner._apply_difficulty()
	assert(is_equal_approx(spawner.reach_time, 2.2), "round 11 should step down twice, got %f" % spawner.reach_time)

	spawner.round_count = 1000
	spawner._apply_difficulty()
	assert(is_equal_approx(spawner.reach_time, spawner.MIN_REACH_TIME), "reach_time should clamp to minimum, got %f" % spawner.reach_time)

	print("Difficulty scaling smoke test: PASS")
	get_tree().quit()
