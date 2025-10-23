class_name Figure
extends Node2D

@export var color: Color = Color.BLACK:
	set(value):
		color = value
		queue_redraw()
