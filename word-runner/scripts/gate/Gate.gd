extends Area2D
## A single word gate. See GAME_RULES.md section 4: Gates.

const ART_PATH := "res://assets/gates/gate_blue.png"

var word_data: Dictionary = {}
var is_correct: bool = false

@onready var label: Label = $Label
@onready var body: ColorRect = $Body
@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
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

func setup(data: Dictionary, correct: bool) -> void:
	word_data = data
	is_correct = correct
	label.text = data.get("word", "")

func move_to(target_y: float, duration: float) -> void:
	var tween := create_tween()
	tween.tween_property(self, "position:y", target_y, duration).set_trans(Tween.TRANS_LINEAR)
