@tool
class_name Waves
extends Node

@export var enemies: Dictionary = {}
@export_group('Add Enemy', 'enemy_')
@export var enemy_scene: PackedScene
@export var enemy_name: String = ''
@export var enemy_add: bool = false:
	set(value):
		if value:
			enemies[enemy_name] = enemy_scene
			enemy_name = ''
			enemy_scene = null
@export var rounds: Array = [{ 'Bubble': 3 }, { 'Bubble': 5 }]
