class_name Entity
extends Node2D

const ENTITY_Z_INDEX = 100
const WALKING = "walking"
const TURN_LEFT = 'turn_left'
const TURN_RIGHT = 'turn_right'

static var entity_counter: int = 0
var __id: int = -1

@export var stats: Stats = Stats.new()

var body: CharacterBody2D

var state: State:
	get():
		if not state:
			state = State.new(stats)
		return state
var movement: Walker

'''  -- Life cycle -- '''
func _init() -> void:
	# Id setting.
	__id = entity_counter
	entity_counter += 1
	
	# Set some attributes.
	y_sort_enabled = true
	z_index = ENTITY_Z_INDEX
	
	# Set movement.
	movement = Walker.new(self)


func _ready() -> void:
	set_body()


func _exit_tree() -> void:
	if movement:
		movement.queue_free()


''' -- Setter-Getter -- '''
func set_body():
	body = CharacterBody2D.new()
	add_child(body)


''' -- Entity Interaction -- '''
func attacked(amount: float):
	if state.receive_damage(amount):
		die()


func apply_damage(ente: Entity):
	var attack_damage = state.curr_damage
	ente.attacked(attack_damage)


func die():
	queue_free()
