extends Control

@onready var menu: Control = $MainMenu
@onready var game: Game = $Game

func _ready() -> void:
	pass


func _on_main_menu_lets_play() -> void:
	menu.visible = false
	game.start_game()
