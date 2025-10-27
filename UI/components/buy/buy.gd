@tool
class_name Buy
extends Node2D

@export var label_text: String = "":
	set(value):
		if value and label:
			label.text = value
		label_text = value

@onready var label: Label = $Label

func _ready() -> void:
	label.text = label_text
	z_as_relative = false
	z_index = 1000
	print(label_text)
