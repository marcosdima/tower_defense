class_name Road
extends Ground



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
	
	# Set different curve points according to the calculated measurements.
	var center = get_center()
	var top_right = get_top_right()
	var top_left = get_top_left()
	var bottom_left = get_bottom_left()
	var bottom_right = get_bottom_right()
	
	var match_func = func(p: Point):
		match p:
			Point.TopLeft: points.append(top_left)
			Point.TopRight: points.append(top_right)
			Point.BottomLeft: points.append(bottom_left)
			_: points.append(bottom_right)
	
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
