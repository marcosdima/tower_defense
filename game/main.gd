extends Node2D

@export var enemy_scene: PackedScene

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	self.add_child(enemy)
	$Path2D.start_walk(enemy)
