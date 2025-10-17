extends Walker

static var count: int = 0

func _ready() -> void:
	name = 'Enemy %s' % [count]
	count += 1

func _draw() -> void:
	self.draw_circle(Vector2.ZERO, 10, Color.RED)
