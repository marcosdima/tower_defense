class_name Rock
extends Projectile

func _process(delta: float) -> void:
	rotate(10 * delta)
	super(delta)
