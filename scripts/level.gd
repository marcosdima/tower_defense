extends Node2D

@export var enemy: PackedScene
@onready var path: Path = $Path
@onready var map: IsometricMap = $IsometricMap

var i: int = 0

func _on_button_pressed() -> void:
	if enemy:
		var instance = enemy.instantiate()
		self.add_child(instance)
		#path.start_walk(instance)
		print(map.path_tiles[i].receive_entity(instance))
