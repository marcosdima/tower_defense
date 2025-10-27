@tool
class_name UFO
extends Enemy

@export_group("Colors", "color_")
@export var color_capsule: Color = Color.FLORAL_WHITE
@export var color_first_layer: Color = Color.DARK_CYAN
@export var color_second_layer: Color = Color.WHEAT

var sprite: Sprite2D

var capsule: Circle
var first_layer: Circle
var second_layer: Circle
var shadow: Circle

var flag_lev: bool = false

func _ready() -> void:
	super()
	_set_sprite()
	_set_colors()
	#_appear()


## Overwrited from Entity.
func set_body():
	super()
	
	var shape = CapsuleShape2D.new()
	shape.radius = 15
	shape.height = 40
	
	var collision = CollisionShape2D.new()
	collision.shape = shape
	collision.rotate(deg_to_rad(90))
	body.add_child(collision)


## Set UFO sprite.
func _set_sprite():
	var texture = load("res://assets/enemies/ufo.png")
	sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.scale = Vector2(0.1, 0.1)
	add_child(sprite)


## Set circle fields.
func _set_colors():
	var _set_basic_circle = func(c: Circle, z: int, y_offest: int):
		sprite.add_child(c)
		c.z_index = z
		c.position.y = y_offest
	
	capsule = Circle.new(color_capsule, 7, 1.4)
	_set_basic_circle.call(capsule, -1, -60)
	
	first_layer = Circle.new(color_first_layer, 9, 1.5)
	_set_basic_circle.call(first_layer, -2, -20)
	
	second_layer = Circle.new(color_second_layer, 9, 2)
	_set_basic_circle.call(second_layer, -3, 40)
	
	shadow = Circle.new(Color.BLACK, 0.9, 1.5)
	shadow.modulate.a = 0.3
	shadow.z_index = -4
	add_child(shadow)
	shadow.position.y = 15


## Appear animation.
func _appear():
	var tween = create_tween()
	tween.set_parallel(true)
	
	var offset = 700
	var start_pos = sprite.position.y - offset
	sprite.position.y = start_pos
	tween.tween_property(sprite, "position:y", sprite.position.y + offset, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	var aux_mod = shadow.modulate.a
	shadow.modulate.a = 0.0
	tween.tween_property(shadow, "modulate:a", aux_mod, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)


## Levitating animation.
func _levitating():
	var tween = create_tween()
	tween.set_loops()
	
	# Movimiento vertical
	var offset = 13
	var radio_offset = 0.3
	tween.tween_property(sprite, "position:y", sprite.position.y - offset, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(shadow, "radio", shadow.radio + radio_offset, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# Volver a estado original
	tween.tween_property(sprite, "position:y", sprite.position.y, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.parallel().tween_property(shadow, "radio", shadow.radio, 0.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
