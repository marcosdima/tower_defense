extends CanvasLayer
class_name HUD

signal next_pressed

@onready var gold_label: Label = $Top/TopHorizontal/Gold/GoldLabel
@onready var wave_label: Label = $Top/TopHorizontal/Wave/WaveLabel
@onready var lives_label: Label = $Top/TopHorizontal/Lives/LivesLabel
@onready var next_wave_label: Label = $NextWave/Container/NextWaveLabel

func set_gold(value: int) -> void:
	gold_label.text = 'Gold: %d' % value


func set_wave(value: int) -> void:
	wave_label.text = 'Wave: %d' % value


func set_lives(value: int) -> void:
	lives_label.text = 'Lives: %d' % value


func set_next_wave_in(value: int) -> void:
	next_wave_label.text = 'Next Wave in %ds' % value


func _on_next_pressed() -> void:
	next_pressed.emit()
