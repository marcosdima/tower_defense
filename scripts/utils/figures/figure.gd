class_name Figure
extends Node2D

@export var color: Color = Color.BLACK:
	set(value):
		color = value
		queue_redraw()


func _init(set_color: Color = Color.BLACK) -> void:
	color = set_color
