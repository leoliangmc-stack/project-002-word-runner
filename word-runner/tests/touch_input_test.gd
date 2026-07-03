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

	print("Touch input smoke test: PASS")
	get_tree().quit()
