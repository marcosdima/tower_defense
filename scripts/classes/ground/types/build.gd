class_name Build
extends Ground

const WAIT = 100

var aux_pos: float
var last_hover_time: int
var builded: bool = false
var buy_sign: Buy

func _ready() -> void:
	super()
	
	input_event.connect(_handle_input_event)
	aux_pos = sprite.position.y
	mouse_def = Input.CURSOR_POINTING_HAND
	
	# Buy sign.
	var sign_scene = load("res://UI/components/buy/Buy.tscn") as PackedScene
	buy_sign = sign_scene.instantiate()
	buy_sign.scale = Vector2.ZERO
	buy_sign.position = Vector2(0, -60)
	call_deferred("add_child", buy_sign)


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
	if event is InputEventMouseButton and event.is_released() and not builded:
		_build_tower()


## Go up animation.
func _go_up():
	if builded: return
	
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", aux_pos - 20, 0.2)
	tween.parallel().tween_property(buy_sign, "scale", Vector2.ONE, 0.2)
	
	last_hover_time = Time.get_ticks_msec()


## Go down animation.
func _go_down():
	var tween = create_tween()
	tween.tween_property(sprite, "position:y", aux_pos, 0.2)
	tween.parallel().tween_property(buy_sign, "scale", Vector2.ZERO, 0.2)


## Instantiate a tower scene.
func _build_tower():
	builded = true
	mouse_def = Input.CURSOR_ARROW
	_go_down()
	
	var tower = preload("res://scenes/tower/Tower.tscn").instantiate()
	tower.position.y -= 30
	tower.z_index = 1000
	add_child(tower)
