@tool
class_name IsometricMap
extends Node2D

enum Type {
	Grass,
	Dirt,
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

func _ready() -> void:
	# Set border with grass.
	_spawn_sprite(Type.Grass, heigth, width)
	for i in range(-1, max(width, heigth)):
		if (i < heigth):
			_spawn_sprite(Type.Grass, i, -1)
			_spawn_sprite(Type.Grass, i, width)
		if (i < width):
			_spawn_sprite(Type.Grass, -1, i)
			_spawn_sprite(Type.Grass, heigth, i)
	
	# Set path of dirt.
	var path_memory: Array[Vector2] = []
	for coord in coords:
		var x = coord['x']
		var y = coord['y']
		path_memory.append(Vector2(x, y))
		_spawn_sprite(coord['type'], x, y)
	
	# Fill empty spaces with grass.
	for i in range(heigth):
		for j in range(width):
			var aux = Vector2(i, j)
			if path_memory.find(aux) < 0:
				_spawn_sprite(Type.Grass, i, j)


func get_texture(type: Type) -> CompressedTexture2D:
	var base = 'res://assets/ground/'
	var path = '%s/%s.png' % [base, Type.find_key(type).to_lower()]
	return load(path)


func _spawn_sprite(
	type: Type,
	gx: int = 0,
	gy: int = 0,
):
	var sprite = Sprite2D.new()
	sprite.texture = get_texture(type)
	
	var pos = _calculate_position(gx, gy, sprite.texture.get_size())
	
	sprite.position = pos
	sprite.z_index = 1
	sprite.y_sort_enabled = true
	
	add_child(sprite)


func _calculate_position(gx: int, gy: int, sprite_size: Vector2) -> Vector2:
	var x = (gx - gy) * (sprite_size.x / 2)
	var y = (gy + gx) * (sprite_size.y * 0.3)
	return Vector2(x, y)
