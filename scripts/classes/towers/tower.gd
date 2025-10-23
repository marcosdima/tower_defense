extends Node2D

@onready var area: Area2D = $Area2D
@export var projectile_scene: PackedScene

@onready var reload_timer: Timer = $Timers/Reload
@onready var find_timer: Timer = $Timers/FindTarget

var reloaded: bool = false
var targets: Array[Node2D] = []
var current_target: Node2D

func _ready() -> void:
	_appear()
	reload_timer.start()
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)


func _appear():
	var aux_pos = position.y
	position.y = aux_pos + 40
	var tween = create_tween()
	tween.tween_property(self, "position:y", aux_pos, 0.3)


func _on_body_entered(body: Node2D) -> void:
	var target = body.get_parent()
	if target is Enemy:
		targets.append(target)
		if current_target == null and find_timer.is_stopped():
			_select_new_target()


func _on_body_exited(body: Node2D) -> void:
	var target = body.get_parent()
	if target in targets:
		targets.erase(target)
		if target == current_target:
			_select_new_target()


## Routine to update current target.
func _select_new_target():
	current_target = null
	find_timer.start()


## Shoots at target if the ammo was reloaded.
func _shoot():
	if current_target and reloaded:
		# Instantiate a projectile scene.
		var p = projectile_scene.instantiate() as Projectile
		add_child(p)
		
		# Set target.
		p.set_target(current_target, global_position)
		
		# Reset flag and reload.
		reloaded = false
		reload_timer.start()


''' Timer functions'''
func _on_find_target_timeout() -> void:
	if !targets.is_empty():
		var sorted = targets.filter(is_instance_valid)
		sorted.sort_custom(func(a, b): return a.movement.progress > b.movement.progress)
		current_target = sorted.front()
		
		if reloaded:
			_shoot()
		elif reload_timer.is_stopped():
			reload_timer.start()


func _on_reload_timeout() -> void:
	reloaded = true
	_shoot()
