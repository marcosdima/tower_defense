class_name Entity
extends Node2D

const WALKING = "walking"
const TURN_LEFT = 'turn_left'
const TURN_RIGHT = 'turn_right'

static var entity_counter: int = 0
var __id: int = -1

@export var stats: Stats = Stats.new()

var body: CharacterBody2D
var animate: AnimationPlayer

var state: State:
	get():
		if not state:
			state = State.new(stats)
		return state
var movement: Walker

func _init() -> void:
	# Id setting.
	__id = entity_counter
	entity_counter += 1
	
	# Set some attributes.
	y_sort_enabled = true
	z_index = 10
	
	# Set movement.
	movement = Walker.new(self)


func _ready() -> void:
	# Set component children.
	_set_children()


func _process(_delta):
	if animate and movement:
		if movement.is_walking:
			if not animate.is_playing():
				animate.play(WALKING)
		else:
			animate.stop()


func _set_children():
	var missing: Array = []
	for c in get_children():
		if not body and c is CharacterBody2D:
			body = c
		elif not animate and c is AnimationPlayer:
			animate = c
	
	if not body:
		missing.append('CharacterBody2D')
	if not animate:
		missing.append('AnimationPlayer')
	if not missing.is_empty():
		printerr('Missing: ', missing)


func _exit_tree() -> void:
	movement.queue_free()


func attacked(amount: float):
	if state.receive_damage(amount):
		die()


func apply_damage(ente: Entity):
	var attack_damage = state.curr_damage
	ente.attacked(attack_damage)


func die():
	print("%s was killed..." % [name])
	queue_free()
