extends Enemy

@export var healthbar_scene: PackedScene

func _ready():
	super()
	if healthbar_scene:
		var bar = healthbar_scene.instantiate()
		add_child(bar)
		bar.target = self

func _draw() -> void:
	self.draw_circle(Vector2.ZERO, 10, Color.RED)
