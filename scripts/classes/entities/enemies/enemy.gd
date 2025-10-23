class_name Enemy
extends Entity

func _init() -> void:
	super()
	name = "Enemy %s" % [__id]
