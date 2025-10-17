extends PathFollow2D
class_name Walker

signal walk(distance: float)

@export var speed = 100.0

func _process(delta):
	self.walk.emit(progress + (speed * delta))
