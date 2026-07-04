extends Control
## Draws lives as vector hearts. Avoids the U+2665 text glyph, which some
## exported/runtime fonts lack (renders as the literal codepoint "2665" instead
## of a heart) — see GameScene.gd lives display.

const HEART_DIAMETER := 28.0
const HEART_SPACING := 8.0
const POINT_COUNT := 24

@export var heart_color: Color = Color(0.9568627, 0.2588235, 0.2117647, 1)

var lives: int = 0

func set_lives(new_lives: int) -> void:
	if lives == new_lives:
		return
	lives = new_lives
	queue_redraw()

func _draw() -> void:
	for i in range(lives):
		var center := Vector2(HEART_DIAMETER / 2.0 + i * (HEART_DIAMETER + HEART_SPACING), size.y / 2.0)
		_draw_heart(center, HEART_DIAMETER, heart_color)

## Parametric heart curve (x = 16 sin^3 t), sampled into a polygon and scaled
## to fit the requested diameter.
func _draw_heart(center: Vector2, diameter: float, color: Color) -> void:
	var points := PackedVector2Array()
	var scale_factor := diameter / 34.0
	for i in range(POINT_COUNT):
		var t := TAU * i / float(POINT_COUNT)
		var hx := 16.0 * pow(sin(t), 3)
		var hy := -(13.0 * cos(t) - 5.0 * cos(2.0 * t) - 2.0 * cos(3.0 * t) - cos(4.0 * t))
		points.append(center + Vector2(hx, hy) * scale_factor)
	draw_colored_polygon(points, color)
