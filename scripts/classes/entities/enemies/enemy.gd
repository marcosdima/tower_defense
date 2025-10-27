class_name Enemy
extends Entity

signal killed

func _init() -> void:
	super()
	name = "Enemy %s" % [__id]


func die():
	killed.emit()
	super()
