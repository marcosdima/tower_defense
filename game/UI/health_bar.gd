extends ProgressBar
class_name HealthBar

var target: Entity

func _ready():
	show_percentage = false
	value = 100
	max_value = 100
	modulate = Color(0.2, 1, 0.2)
	set_anchors_preset(Control.PRESET_CENTER_TOP)
	position = Vector2(0, -30)


func _process(_delta):
	if not target or not is_instance_valid(target):
		queue_free()
		return
	value = target.state.curr_health
	max_value = target.state.base_stats.health
