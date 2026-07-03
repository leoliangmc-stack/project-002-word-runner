extends Node2D
## Discrete 3-lane player controller. See GAME_RULES.md section 3: Lanes.

signal lane_changed(lane_index: int)

const LANE_COUNT := 3
const MOVE_DURATION := 0.15
const ART_PATH := "res://assets/player/player_idle.png"

var current_lane: int = 1
var lane_positions: Array[float] = []
var _move_tween: Tween

@onready var visual: Node2D = $Visual
@onready var body: ColorRect = $Visual/Body
@onready var sprite: Sprite2D = $Visual/Sprite

func _ready() -> void:
	lane_positions = compute_lane_positions(get_viewport_rect().size.x)
	position.x = lane_positions[current_lane]
	_load_art()

## Uses the art file when present, otherwise keeps the placeholder color block.
## See ASSET.md: gameplay must never stop because of missing art.
func _load_art() -> void:
	if ResourceLoader.exists(ART_PATH):
		sprite.texture = load(ART_PATH)
		_fit_sprite_to_box(sprite, body)
		sprite.show()
		body.hide()

## Art files can come in at any resolution, so scale (preserving aspect ratio)
## and reposition the sprite to match the placeholder's footprint instead of
## drawing at the texture's native pixel size.
func _fit_sprite_to_box(target_sprite: Sprite2D, box: ColorRect) -> void:
	var tex_size := target_sprite.texture.get_size()
	if tex_size.x <= 0 or tex_size.y <= 0:
		return
	var scale_factor := minf(box.size.x / tex_size.x, box.size.y / tex_size.y)
	target_sprite.scale = Vector2(scale_factor, scale_factor)
	target_sprite.position = box.position + box.size / 2.0

func compute_lane_positions(viewport_width: float) -> Array[float]:
	var positions: Array[float] = []
	for i in range(LANE_COUNT):
		positions.append(viewport_width * (i + 1) / float(LANE_COUNT + 1))
	return positions

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):
		move_to_lane(current_lane - 1)
	elif event.is_action_pressed("ui_right"):
		move_to_lane(current_lane + 1)

func move_to_lane(lane_index: int) -> void:
	lane_index = clampi(lane_index, 0, LANE_COUNT - 1)
	if lane_index == current_lane:
		return
	current_lane = lane_index
	lane_changed.emit(current_lane)
	_animate_to_lane()

func _animate_to_lane() -> void:
	if _move_tween:
		_move_tween.kill()
	_move_tween = create_tween()
	_move_tween.tween_property(self, "position:x", lane_positions[current_lane], MOVE_DURATION) \
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

## Success feedback: green flash only, no bounce, so play continues smoothly. See GAME_RULES.md section 16.
func flash_correct() -> void:
	_flash(Color(0.3, 0.8, 0.3, 1.0))

## Failure feedback: small shake + red flash. See GAME_RULES.md section 17.
func play_wrong() -> void:
	var shake := create_tween()
	var base_x := visual.position.x
	for i in range(4):
		var offset := 10.0 if i % 2 == 0 else -10.0
		shake.tween_property(visual, "position:x", base_x + offset, 0.05)
	shake.tween_property(visual, "position:x", base_x, 0.05)
	_flash(Color(0.9, 0.2, 0.2, 1.0))

## Tints whichever visual is active (placeholder block or art sprite), then fades back.
## Modulate works for both node types, so this doesn't care which one is showing.
func _flash(color: Color) -> void:
	visual.modulate = color
	var flash := create_tween()
	flash.tween_property(visual, "modulate", Color.WHITE, 0.4)
