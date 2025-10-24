extends Control

@onready var menu: Control = $MainMenu
@onready var level: Node2D = $Level

func _ready() -> void:
	pass


func _on_main_menu_lets_play() -> void:
	menu.visible = false
	level.visible = true
	level.start_level()
