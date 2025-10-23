class_name Projectile
extends Area2D

@export var speed := 400.0
@export var damage := 10.0

var target: Enemy = null

func _ready() -> void:
	z_index += 10


func _draw() -> void:
	draw_circle(Vector2.ZERO, 5, Color.BLACK)


func _process(delta: float) -> void:
	if not target or not is_instance_valid(target):
		queue_free()
		return
	
	var dir = (target.global_position - global_position).normalized()
	global_position += dir * speed * delta


func set_target(
	new_target: Enemy,
	initial_position: Vector2,
) -> void:
	global_position = initial_position
	target = new_target
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.get_parent() == target:
		_hit_target()


func _hit_target() -> void:
	
	if target and is_instance_valid(target):
		if target is Enemy:
			target.attacked(damage)
		else:
			printerr('Target was not an enemy')
	queue_free()
