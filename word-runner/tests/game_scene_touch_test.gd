extends Node2D
## Scene-composition test: touches inside the play area must reach the Player.
## Guards against full-screen Controls (Background, HUD) swallowing touches
## before they reach Player._unhandled_input — the touch logic itself is
## covered by touch_input_test.gd; this covers the Game.tscn node stack.
## (Desktop mouse clicks become emulated ScreenTouch in the Input pipeline and
## take this same route; headless can't simulate that upstream part, so only
## the touch route is asserted here.) Run as main scene:
## godot --headless --path . res://tests/GameSceneTouchTestScene.tscn

const GameScene := preload("res://scenes/game/Game.tscn")

func _ready() -> void:
	var game = GameScene.instantiate()
	add_child(game)
	var player = game.get_node("Player")
	assert(player.current_lane == 1, "player should start in the middle lane")

	# Tap inside the Background/HUD rect (1152x648), left then right half.
	_tap(Vector2(300, 300))
	assert(player.current_lane == 0,
		"a tap inside the play area should move the player one lane left")

	_tap(Vector2(900, 300))
	assert(player.current_lane == 1,
		"a tap on the right half of the play area should move one lane right")

	print("Game scene touch test: PASS")
	get_tree().quit()

## Positions are viewport-local (in_local_coords = true): the headless window
## size differs from the game viewport, so window coords would get rescaled.
func _tap(at: Vector2) -> void:
	var press := InputEventScreenTouch.new()
	press.index = 0
	press.position = at
	press.pressed = true
	get_viewport().push_input(press, true)

	var release := InputEventScreenTouch.new()
	release.index = 0
	release.position = at
	release.pressed = false
	get_viewport().push_input(release, true)
