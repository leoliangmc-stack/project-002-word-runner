extends Node2D
## Smoke test for touch-based lane switching (phones have no keyboard). Run as main scene:
## godot --headless --path . res://tests/TouchInputTestScene.tscn

const PlayerScene := preload("res://scenes/player/Player.tscn")

func _ready() -> void:
	var player = PlayerScene.instantiate()
	add_child(player)
	player.lane_positions = player.compute_lane_positions(900.0)
	player.move_to_lane(1)

	var viewport_width: float = player.get_viewport_rect().size.x
	player._handle_touch(Vector2(viewport_width * 0.25, 0))
	assert(player.current_lane == 0, "tapping the left half should move one lane left")

	player._handle_touch(Vector2(viewport_width * 0.75, 0))
	assert(player.current_lane == 1, "tapping the right half should move one lane right")

	player.move_to_lane(1)
	player._drag_accumulated = 0.0
	player._handle_drag(player.SWIPE_LANE_DISTANCE)
	assert(player.current_lane == 2, "sliding right past the threshold should move one lane right")

	player._handle_drag(-player.SWIPE_LANE_DISTANCE * 2.0)
	assert(player.current_lane == 0, "sliding left past two thresholds should move two lanes left")

	player.move_to_lane(1)
	player._touch_start_position = Vector2(viewport_width * 0.25, 0)
	player._drag_accumulated = player.SWIPE_LANE_DISTANCE
	player._handle_touch_release(Vector2(viewport_width * 0.25 + player.SWIPE_LANE_DISTANCE, 0))
	assert(player.current_lane == 1, "a released drag should not also trigger a tap move")

	print("Touch input smoke test: PASS")
	get_tree().quit()
