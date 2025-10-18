class_name Path
extends Path2D

func start_walk(ente: Entity):
	ente.movement.set_path(self)


func ended(distance: float) -> bool:
	return distance >= curve.get_baked_length()
