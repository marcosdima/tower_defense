class_name Projectile
extends Area2D

@export var speed := 400.0
@export var damage := 10.0

var target: Walker = null

func set_target(
	new_target: Walker,
	initial_position: Vector2,
) -> void:
	global_position = initial_position
	target = new_target
	body_entered.connect(_on_body_entered)


func _draw() -> void:
	draw_circle(Vector2.ZERO, 5, Color.BLACK)


func _process(delta: float) -> void:
	if not target or not is_instance_valid(target):
		queue_free()
		return
	
	var dir = (target.global_position - global_position).normalized()
	global_position += dir * speed * delta
	
	rotation = dir.angle()


func _on_body_entered(body: Node2D) -> void:
	if body == target:
		_hit_target()


func _hit_target() -> void:
	if target and is_instance_valid(target):
		print("Hit %s for %.1f damage" % [target.name, damage])
	queue_free()
