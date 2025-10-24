class_name Ground
extends Area2D

enum Type {
	Grass,
	Dirt,
	Build,
	Tower,
}

var type: Type = Type.Grass
var sprite: Sprite2D = Sprite2D.new()
var sprite_size: Vector2:
	get():
		if !sprite_size and sprite:
			sprite_size = sprite.texture.get_size()
		return sprite_size
var collision = CollisionPolygon2D

# Map coords.
var x_coord: int
var y_coord: int

# Default mouse.
var mouse_def = Input.CURSOR_ARROW

func _init(x: int, y: int) -> void:
	x_coord = x
	y_coord = y
	y_sort_enabled = true
	name = 'Ground %s-%s' % [x, y]
	_set_texture()


func _ready() -> void:
	_set_collision()
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _move_up_down():
	var tween = create_tween()
	var start_pos = sprite.position
	var down_pos = start_pos + Vector2(0, 20)
	
	tween.tween_property(sprite, "position", down_pos, 0.15)
	tween.tween_property(sprite, "position", start_pos, 0.15)


## On mouse entered.
func _on_mouse_entered():
	Input.set_default_cursor_shape(mouse_def)


## On mouse entered.
func _on_mouse_exited():
	pass


## Set sprite and its texture.
func _set_texture():
	var base = 'res://assets/ground/'
	var path = '%s/%s.png' % [base, Type.find_key(type).to_lower()]
	sprite.texture = load(path)
	add_child(sprite)


## Set collision polygon.
func _set_collision():
	collision = CollisionPolygon2D.new()
	
	collision.polygon = [
		Vector2(0, 10),
		Vector2(-56, -23),
		Vector2(0, -55),
		Vector2(56, -23),
	]
	
	add_child(collision)
