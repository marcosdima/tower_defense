@tool
class_name Game
extends Node2D

const GOLD_BY_KILL = 10 
const TIME_BETWEEN_WAVES = 30 * 1000

# Game variables.
var gold: int = 0
var lives: int = 3
var wave: int = 0

# Game stats.
var kill_count: int = 0

@export var level_scene: PackedScene
@export var hud_scene: PackedScene

var current_level: Level
var hud: HUD
var waves_timer: Timer

func _ready() -> void:
	# Set timer.
	waves_timer = Timer.new()
	waves_timer.one_shot = true
	waves_timer.timeout.connect(next_wave)
	add_child(waves_timer)


func _process(_delta: float) -> void:
	# Updates time in hud.
	if hud:
		hud.set_next_wave_in(int(waves_timer.time_left))


## Routine to set game.
func start_game() -> void:
	current_level = level_scene.instantiate()
	hud = hud_scene.instantiate()

	add_child(current_level)
	add_child(hud)
	
	current_level.position = Vector2(500, 200)
	current_level.set_level()
	
	hud.next_pressed.connect(next_wave)
	update_hud()
	
	waves_timer.wait_time = current_level.time_between_waves
	waves_timer.start()


## What happens when an enemy is killed.
func on_kill():
	gold += GOLD_BY_KILL
	kill_count += 1


## Routine to set the new wave.
func next_wave():
	if !waves_timer.is_stopped():
		waves_timer.stop()
	
	wave += 1
	current_level.spawn_wave(wave)
	waves_timer.start()
	update_hud()


## Updates hud label values.
func update_hud():
	if !hud:
		return
	hud.set_gold(gold)
	hud.set_lives(lives)
	hud.set_wave(wave)
