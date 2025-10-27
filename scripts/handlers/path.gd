@tool
class_name Path
extends Path2D

signal walk_ended(ente: Enemy)

func _init() -> void:
	if !curve:
		curve = Curve2D.new()


func add_walker(ente: Enemy):
	var walker = ente.movement
	walker.path = self
	walker.progress = 0
	
	add_child(walker)
	ente.global_position = walker.global_position
	
	ente.movement.is_walking = true


func ended(distance: float) -> bool:
	return distance >= curve.get_baked_length()


func handle_end_path(ente: Enemy):
	walk_ended.emit(ente)
