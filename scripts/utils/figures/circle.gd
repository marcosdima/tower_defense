@tool
class_name Circle
extends Figure

@export_range(0.0, 10.0, 0.1)
var radio: float = 1:
	set(value):
		radio = value
		queue_redraw()

func _draw() -> void:
	draw_circle(Vector2.ZERO, radio * 10, color)


func calc_radio() -> float:
	var view_rect_size = get_viewport_rect().size
	return (view_rect_size.x / 100) * radio
