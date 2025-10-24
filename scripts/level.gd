@tool
class_name Level
extends Node2D

const coords: Array[Dictionary] = [
	{"type": IsometricMap.Type.Dirt, "x": 0, "y": 0},
	{"type": IsometricMap.Type.Dirt, "x": 0, "y": 1},
	{"type": IsometricMap.Type.Dirt, "x": 0, "y": 2},
	{"type": IsometricMap.Type.Dirt, "x": 0, "y": 3},
	{"type": IsometricMap.Type.Dirt, "x": 1, "y": 3},
	{"type": IsometricMap.Type.Dirt, "x": 2, "y": 3},
	{"type": IsometricMap.Type.Dirt, "x": 2, "y": 2},
	{"type": IsometricMap.Type.Dirt, "x": 2, "y": 1},
	{"type": IsometricMap.Type.Dirt, "x": 2, "y": 0},
	{"type": IsometricMap.Type.Dirt, "x": 3, "y": 0},
	{"type": IsometricMap.Type.Dirt, "x": 4, "y": 0},
	{"type": IsometricMap.Type.Dirt, "x": 4, "y": 1},
	{"type": IsometricMap.Type.Dirt, "x": 4, "y": 2},
	{"type": IsometricMap.Type.Dirt, "x": 5, "y": 2},
]

@export var enemy: PackedScene
@export var setup: bool = false:
	set(value):
		if value:
			start_level()
		value = false
@export_group("Map", "map_")
@export var map_width: int = 4
@export var map_heigth: int = 6
@export var map_initial_direction: Road.Point = Road.Point.TopRight
@export var map_end_direction: Road.Point = Road.Point.BottomRight

var map: IsometricMap
var path: Path

func start_level() -> void:
	_set_map()
	
	path = Path.new()
	add_child(path)
	
	for road in map.map_road:
		for point in road.points:
			path.curve.add_point(road.position + point)
		road._move_up()
		await get_tree().create_timer(0.1).timeout


func _on_button_pressed() -> void:
	if enemy:
		var instance = enemy.instantiate()
		self.add_child(instance)
		path.start_walk(instance)


func _set_map():
	if map and map.get_parent() == self:
		remove_child(map)
	
	map = IsometricMap.new()
	
	map.z_index += 1
	map.map_road_coords = coords
	map.width = map_width
	map.height = map_heigth
	map.initial_direction = map_initial_direction
	map.end_direction = map_end_direction
	
	add_child(map)
