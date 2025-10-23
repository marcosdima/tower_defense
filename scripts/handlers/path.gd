@tool
class_name Path
extends Path2D

func _init() -> void:
	if !curve:
		curve = Curve2D.new()


func start_walk(ente: Enemy):
	ente.movement.set_path(self)


func ended(distance: float) -> bool:
	return distance >= curve.get_baked_length()
