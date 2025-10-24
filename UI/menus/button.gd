class_name ButtonCustom
extends Control

signal pressed

const OFFSET = 100
const DURATION = 0.5

var aux_pos: Vector2

@onready var real_button: Button = $RealButton
@export var text: String = "Button":
	set(value):
		text = value
		if real_button:
			real_button.text = text


func _ready() -> void:
	real_button.text = text
	real_button.pressed.connect(pressed.emit)
	real_button.mouse_entered.connect(_scale)
	real_button.mouse_exited.connect(_scale.bind(1))

func _set_move():
	real_button.modulate.a = 0
	aux_pos = real_button.position
	real_button.position.y += OFFSET


func _move():
	real_button.modulate.a = 1
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(real_button, "position:y", aux_pos.y, DURATION)


func _scale(scale_to: float = 1.1):
	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	
	if scale_to > 1.0:
		var offset = ((size.x * scale_to) - size.x) / 2
		tween.tween_property(real_button, "scale", Vector2(scale_to, scale_to), 0.1)
		tween.parallel().tween_property(real_button, "position:x", real_button.position.x - offset, 0.1)
	else:
		tween.tween_property(real_button, "scale", Vector2(1, 1), 0.1)
		tween.parallel().tween_property(real_button, "position:x", aux_pos.x, 0.1)
