extends Node2D

@onready var hud: HUD = $HUD

func _ready():
	hud.set_gold(100)
	hud.set_wave(1)
	hud.set_lives(20)
