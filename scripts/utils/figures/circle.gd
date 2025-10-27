@tool
class_name Circle
extends Figure

@export_range(0.0, 20.0, 0.1)
var radio: float = 1:
	set(value):
		radio = value
		queue_redraw()
@export_range(0.0, 5.0, 0.1)
var long: float = 1:
	set(value):
		long = value
		scale = Vector2(long, 1)
		queue_redraw()


func _init(
	set_color: Color = Color.BLACK,
	set_radio: float = 1.0,
	set_long: float = 1.0
) -> void:
	super(set_color)
	radio = set_radio
	long = set_long


func _draw() -> void:
	draw_circle(Vector2.ZERO, radio * 10, color)


func calc_radio() -> float:
	var view_rect_size = get_viewport_rect().size
	return (view_rect_size.x / 100) * radio
