extends CanvasLayer
class_name HUD

@onready var gold_label: Label = $Top/Container/LabelGold
@onready var wave_label: Label = $Top/Container/LabelWave
@onready var lives_label: Label = $Top/Container/LabelLives

func set_gold(value: int) -> void:
	gold_label.text = "Gold: %d" % value


func set_wave(value: int) -> void:
	wave_label.text = "Wave: %d" % value


func set_lives(value: int) -> void:
	lives_label.text = "Lives: %d" % value
