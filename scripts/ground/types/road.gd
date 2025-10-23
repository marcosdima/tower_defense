class_name Road
extends Ground

#var center:
var path: Path

func _init(x: int, y: int) -> void:
	type = IsometricMap.Type.Dirt
	super(x, y)


func _ready() -> void:
	super()
	_set_path()


func _set_path():
	path = Path.new()
	path.z_index += 1
	
	var points = [
		Vector2(sprite_size.x / 4, -(sprite_size.y / 3)),
		Vector2(0, -(sprite_size.y / 5)),
		Vector2(-(sprite_size.x / 4), -4),
	]
	print(points)
	for point in points:
		path.curve.add_point(point) 
	
	add_child(path)


func receive_entity(e: Enemy):
	path.start_walk(e)
