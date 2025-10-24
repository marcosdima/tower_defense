
extends Control

signal lets_play

@onready var buttons: Container = $MarginContainer/VBoxContainer/MarginContainer/Buttons

func _ready() -> void:
	var buttons_children = buttons.get_children()
	
	for button: ButtonCustom in buttons_children:
		button._set_move()
	
	for button: ButtonCustom in buttons_children:
		button._move()
		await get_tree().create_timer(0.2).timeout


func _on_play_pressed() -> void:
	lets_play.emit()
