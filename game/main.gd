extends Node2D

@export var enemy_scene: PackedScene

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	$Path2D.spawn_something(enemy)
