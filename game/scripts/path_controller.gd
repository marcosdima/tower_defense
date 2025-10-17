class_name PathController
extends Path2D

func start_walk(walker: Walker):
	walker.set_path(self)


func ended(distance: float) -> bool:
	return distance >= curve.get_baked_length()
