class_name Build
extends Ground

const WAIT = 100

var aux_pos: float
var last_hover_time: int
var builded: bool = false

func _ready() -> void:
	super()
	input_event.connect(_handle_input_event)
	aux_pos = sprite.position.y
	mouse_def = Input.CURSOR_POINTING_HAND


## Overwritten.
func _on_mouse_entered():
	super()
	_go_up()


## Overwritten.
func _on_mouse_exited():
	super()
	_go_down()


## On input capted.
func _handle_input_event(_viewport: Node, event: InputEvent, _shape_idx: int):
	if event is InputEventMouseButton and event.is_released():
		_build_tower()


## Go up animation.
func _go_up():
	if builded: return
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", aux_pos - 20, 0.2)
	last_hover_time = Time.get_ticks_msec()


## Go down animation.
func _go_down():
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", aux_pos, 0.2)


## Instantiate a tower scene.
func _build_tower():
	builded = true
	_go_down()
	var tower = preload("res://scenes/tower/Tower.tscn").instantiate()
	tower.position.y -= 30
	tower.z_index += 1
	add_child(tower)
