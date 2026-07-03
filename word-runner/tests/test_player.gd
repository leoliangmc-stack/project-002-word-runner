extends SceneTree
## Headless smoke test for Player lane switching. Run with:
## godot --headless --script res://tests/test_player.gd

func _init() -> void:
	var player = load("res://scenes/player/Player.tscn").instantiate()
	root.add_child(player)
	# _ready() runs on an idle frame, not synchronously after add_child, so
	# lane_positions is (re)computed explicitly here for a deterministic test.
	player.lane_positions = player.compute_lane_positions(900.0)

	assert(player.current_lane == 1, "player should start centered")
	assert(player.lane_positions.size() == 3, "expected 3 lane positions")

	player.move_to_lane(0)
	assert(player.current_lane == 0, "expected lane 0 after move_to_lane(0)")

	player.move_to_lane(2)
	assert(player.current_lane == 2, "expected lane 2 after move_to_lane(2)")

	player.move_to_lane(5)
	assert(player.current_lane == 2, "lane index should clamp to max 2")

	player.move_to_lane(-1)
	assert(player.current_lane == 0, "lane index should clamp to min 0")

	var positions = player.lane_positions
	assert(positions[0] < positions[1] and positions[1] < positions[2], "lane positions should be ordered left to right")

	print("Player smoke test: PASS")
	quit()
