@tool
class_name Level
extends Node2D

const coords: Array[Dictionary] = [
	{"type":  Ground.Type.Dirt, "x": 0, "y": 0},
	{"type":  Ground.Type.Dirt, "x": 0, "y": 1},
	{"type":  Ground.Type.Dirt, "x": 0, "y": 2},
	{"type":  Ground.Type.Dirt, "x": 0, "y": 3},
	{"type":  Ground.Type.Dirt, "x": 1, "y": 3},
	{"type":  Ground.Type.Dirt, "x": 2, "y": 3},
	{"type":  Ground.Type.Dirt, "x": 2, "y": 2},
	{"type":  Ground.Type.Dirt, "x": 2, "y": 1},
	{"type":  Ground.Type.Dirt, "x": 2, "y": 0},
	{"type":  Ground.Type.Dirt, "x": 3, "y": 0},
	{"type":  Ground.Type.Dirt, "x": 4, "y": 0},
	{"type":  Ground.Type.Dirt, "x": 4, "y": 1},
	{"type":  Ground.Type.Dirt, "x": 4, "y": 2},
]

const waves: Array[int] = [1, 2, 3, 5, 7, 10]

@export var enemy: PackedScene
@export var time_between_waves: float = 15.0
@export var time_between_spawn: float = 0.5
@export var setup: bool = false:
	set(value):
		if value:
			set_level()
		value = false
@export_group("Map", "map_")
@export var map_width: int = 4
@export var map_heigth: int = 6
@export var map_initial_direction: Road.Point = Road.Point.TopRight
@export var map_end_direction: Road.Point = Road.Point.BottomRight
@export var map_tower_position: Vector2i = Vector2i(5, 2)

var map: IsometricMap
var path: Path

func set_level() -> void:
	_set_map()
	
	if path:
		path.queue_free()
	path = Path.new()
	add_child(path)
	
	for road in map.map_road:
		for point in road.points:
			path.curve.add_point(road.position + point)
		road._move_up_down()
		await get_tree().create_timer(0.1).timeout


func _set_map():
	if map and map.get_parent() == self:
		remove_child(map)
	
	map = IsometricMap.new()
	add_child(map)
	
	map.z_index += 1
	map.map_road_coords = coords
	map.width = map_width
	map.height = map_heigth
	map.initial_direction = map_initial_direction
	map.end_direction = map_end_direction
	map.tower_position = map_tower_position
	
	map.set_map()


func _spawn_enemy() -> Enemy:
	var instance = enemy.instantiate()
	add_child(instance)
	path.start_walk(instance)
	return instance


func spawn_wave(wave: int):
	for i in range(waves[wave - 1]):
		var enemy_instance = _spawn_enemy()
		enemy_instance.name = '%d-%d' % [wave, i]
		await get_tree().create_timer(time_between_spawn).timeout
