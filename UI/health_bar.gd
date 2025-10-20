extends ProgressBar
class_name HealthBar

var target: Entity

func _ready():
	show_percentage = false
	modulate = Color(0.2, 1, 0.2)
	set_anchors_preset(Control.PRESET_CENTER_TOP)
	position = Vector2(-30, -30)


func _process(_delta):
	if not target or not is_instance_valid(target):
		queue_free()
		return
	value = target.state.curr_health
	max_value = target.state.base_stats.health
	
	var width = target.get_visual_size()
	size.x = width
	position = Vector2(-(width / 2), -30)
