@tool
class_name IsometricMap
extends Node2D

var width: int = 4
var height: int = 6
var initial_direction: Road.Point = Road.Point.TopRight
var end_direction: Road.Point = Road.Point.BottomRight

var map_road_coords: Array[Dictionary] = []:
	set(value):
		if !value.is_empty():
			map_road_coords = value
			set_map()
var map_road: Array[Road] = []

func set_map() -> void:
	# Set border with grass.
	_spawn_floor(Ground.Type.Grass, height, width)
	for i in range(-1, max(width, height)):
		if (i < height):
			_spawn_floor(Ground.Type.Grass, i, -1)
			_spawn_floor(Ground.Type.Grass, i, width)
		if (i < width):
			_spawn_floor(Ground.Type.Grass, -1, i)
			_spawn_floor(Ground.Type.Grass, height, i)
	
	# Set path of dirt.
	var path_memory: Array[Vector2] = []
	var aux_prev: Road = null
	for coord in map_road_coords:
		var x = coord['x']
		var y = coord['y']
		path_memory.append(Vector2(x, y))
		
		var curr = _spawn_floor(coord['type'], x, y)
		if aux_prev:
			curr.previus = aux_prev
			aux_prev.next = curr
			aux_prev.set_points(initial_direction, end_direction)
		aux_prev = curr
	aux_prev.set_points(initial_direction, end_direction)
	
	# Fill empty spaces with grass.
	for i in range(height):
		for j in range(width):
			var aux = Vector2(i, j)
			if path_memory.find(aux) < 0:
				_spawn_floor(Ground.Type.Build, i, j)


## Set a floor instance and add it to scene.
func _spawn_floor(
	type: Ground.Type,
	gx: int = 0,
	gy: int = 0,
) -> Ground:
	var floor_obj = get_floor(type, gx, gy)
	
	var pos = _calculate_position(gx, gy, floor_obj.sprite_size)
	
	floor_obj.global_position = pos
	floor_obj.z_index = (gx * 10) + gy
	floor_obj.y_sort_enabled = true
	
	add_child(floor_obj)
	
	return floor_obj


## Calculate ground position with the provided coordinate.
func _calculate_position(gx: int, gy: int, sprite_size: Vector2) -> Vector2:
	var x = (gx - gy) * (sprite_size.x / 2)
	var y = (gy + gx) * (sprite_size.y * 0.3)
	return Vector2(x, y)


## Get Ground instance.
func get_floor(type: Ground.Type, x: int, y: int) -> Ground:
	match type:
		Ground.Type.Build:
			return Build.new(x, y)
		Ground.Type.Dirt:
			var road = Road.new(x, y)
			map_road.append(road)
			return road
		_:
			return Ground.new(x, y)
