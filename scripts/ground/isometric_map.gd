@tool
class_name IsometricMap
extends Node2D

enum Type {
	Grass,
	Dirt,
	Build,
}

@export var width: int = 5
@export var heigth: int = 5

const coords = [
	{"type": Type.Dirt, "x": 0, "y": 0},
	{"type": Type.Dirt, "x": 0, "y": 1},
	{"type": Type.Dirt, "x": 0, "y": 2},
	{"type": Type.Dirt, "x": 0, "y": 3},
	{"type": Type.Dirt, "x": 1, "y": 3},
	{"type": Type.Dirt, "x": 2, "y": 3},
	{"type": Type.Dirt, "x": 2, "y": 2},
	{"type": Type.Dirt, "x": 2, "y": 1},
	{"type": Type.Dirt, "x": 2, "y": 0},
	{"type": Type.Dirt, "x": 3, "y": 0},
	{"type": Type.Dirt, "x": 4, "y": 0},
	{"type": Type.Dirt, "x": 4, "y": 1},
	{"type": Type.Dirt, "x": 4, "y": 2},
	{"type": Type.Dirt, "x": 5, "y": 2},
]

var path_tiles: Array[Road] = []

func _ready() -> void:
	# Set border with grass.
	_spawn_floor(Type.Dirt, 0, 0)
	'''
	_spawn_floor(Type.Grass, heigth, width)
	
	for i in range(-1, max(width, heigth)):
		if (i < heigth):
			_spawn_floor(Type.Grass, i, -1)
			_spawn_floor(Type.Grass, i, width)
		if (i < width):
			_spawn_floor(Type.Grass, -1, i)
			_spawn_floor(Type.Grass, heigth, i)
	
	# Set path of dirt.
	var path_memory: Array[Vector2] = []
	for coord in coords:
		var x = coord['x']
		var y = coord['y']
		path_memory.append(Vector2(x, y))
		_spawn_floor(coord['type'], x, y)
	
	# Fill empty spaces with grass.
	for i in range(heigth):
		for j in range(width):
			var aux = Vector2(i, j)
			if path_memory.find(aux) < 0:
				_spawn_floor(Type.Build, i, j)
	'''


## Set a floor instance and add it to scene.
func _spawn_floor(
	type: Type,
	gx: int = 0,
	gy: int = 0,
):
	var floor_obj = get_floor(type, gx, gy)
	
	var pos = _calculate_position(gx, gy, floor_obj.sprite_size)
	
	floor_obj.global_position = pos
	floor_obj.z_index = gx + gy
	floor_obj.y_sort_enabled = true
	
	add_child(floor_obj)


## Calculate ground position with the provided coordinate.
func _calculate_position(gx: int, gy: int, sprite_size: Vector2) -> Vector2:
	var x = (gx - gy) * (sprite_size.x / 2)
	var y = (gy + gx) * (sprite_size.y * 0.3)
	return Vector2(x, y)


## Get Ground instance.
func get_floor(type: Type, x: int, y: int) -> Ground:
	match type:
		Type.Build:
			return Build.new(x, y)
		Type.Dirt:
			var road = Road.new(x, y)
			path_tiles.append(road)
			return road
		_:
			return Ground.new(x, y)
