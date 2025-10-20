class_name Ground
extends Sprite2D

enum Type {
	Grass,
	Dirt,
}

@export var type: Type = Type.Grass

func _ready() -> void:
	y_sort_enabled = true
	_set_texture()


func _set_texture():
	var base = 'res://assets/ground/'
	var path = '%s/%s.png' % [base, Type.find_key(type).to_lower()]
	texture = load(path)
