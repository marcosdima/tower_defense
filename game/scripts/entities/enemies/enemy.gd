class_name Enemy
extends Entity

var movement: Walker

func _init() -> void:
	super()
	movement = Walker.new(self)


func _ready() -> void:
	super()
	name = "Enemy %s" % [__id]


func _exit_tree() -> void:
	movement.queue_free()
