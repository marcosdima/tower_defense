class_name Enemy
extends Walker

static var count: int = 0
@export var stats: Stats = Stats.new()
var state: State

func _ready() -> void:
	name = 'Enemy %s' % [count]
	count += 1
	
	state = State.new(stats)
	
	## TODO: This will keep like this for now, change it later...
	speed = stats.speed


func _draw() -> void:
	self.draw_circle(Vector2.ZERO, 10, Color.RED)


func receive_damage(amount: float):
	if state.apply_damage(amount):
		die()


func die():
	queue_free()
