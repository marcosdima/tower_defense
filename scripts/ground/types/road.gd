class_name Road
extends Ground

enum Point {
	TopLeft,
	TopRight,
	BottomLeft,
	BottomRight,
}

#var center:
var path: Path
var previus: Road
var next: Road

var points: Array[Vector2] = []

func _init(x: int, y: int) -> void:
	type = Type.Dirt
	super(x, y)


func set_points(initial: Point, end: Point):
	points = []
	
	# This was calculated by testing.
	var top = -(sprite_size.y / 2.9)
	var bottom = -5
	var right = sprite_size.x / 4
	var left = -right
	
	#Set different curve points according to the calculated measurements.
	var center = Vector2(0, -(sprite_size.y / 5))
	var top_right = Vector2(right, top)
	var top_left = Vector2(left, top)
	var bottom_left = Vector2(left, bottom)
	var right_bottom = Vector2(right, bottom)
	
	var match_func = func(p: Point):
		match p:
			Point.TopLeft: points.append(top_left)
			Point.TopRight: points.append(top_right)
			Point.BottomLeft: points.append(bottom_left)
			_: points.append(right_bottom)
	
	match_func.call(_get_from(initial))
	points.append(center)
	match_func.call(_get_to(end))


func _get_from(initial: Point) -> Point:
	if not previus:
		return initial
	
	if previus.y_coord < y_coord:
		return Point.TopRight
	elif previus.x_coord < x_coord:
		return Point.TopLeft
	elif previus.y_coord > y_coord:
		return Point.BottomLeft
	else:
		return Point.BottomRight


func _get_to(end: Point) -> Point:
	if not next:
		return end
	
	if next.y_coord > y_coord:
		return Point.BottomLeft
	elif next.x_coord > x_coord:
		return Point.BottomRight
	elif next.y_coord < y_coord:
		return Point.TopRight
	else:
		return Point.TopLeft
