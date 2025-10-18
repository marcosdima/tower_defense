extends Area2D
class_name Tower

var targets: Array[Node2D] = []
var current_target: Node2D

@export var reload_time: float = 0.5
@export var find_target_time: float = 0.1
@export var projectile_scene: PackedScene

@onready var reload_timer: Timer = $Timers/Reload
@onready var find_timer: Timer = $Timers/FindTarget

var reloaded: bool = false

func _ready() -> void:
	reload_timer.wait_time = reload_time
	find_timer.wait_time = find_target_time
	reload_timer.start()


func _process(_delta: float) -> void:
	# If current target it's not a valid instance.
	if current_target and not is_instance_valid(current_target):
		_select_new_target()


func _on_body_entered(body: Node2D) -> void:
	if body is Walker:
		targets.append(body)
		if current_target == null:
			_select_new_target()


## Routine to
func _on_body_exited(body: Node2D) -> void:
	if body in targets:
		targets.erase(body)
		if body == current_target:
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
		
		# Set target.
		p.set_target(current_target, global_position)
		get_tree().current_scene.add_child(p)
		
		# Reset flag and reload.
		reloaded = false
		reload_timer.start()


''' Timer functions'''
func _on_find_target_timeout() -> void:
	if !targets.is_empty():
		var sorted = targets.filter(is_instance_valid)
		sorted.sort_custom(func(a, b): return a.path_follower.progress > b.path_follower.progress)
		current_target = sorted.front()
		
		if reloaded:
			_shoot()
		elif reload_timer.is_stopped():
			reload_timer.start()


func _on_reload_timeout() -> void:
	reloaded = true
	_shoot()
