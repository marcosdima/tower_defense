class_name Entity
extends Node2D

static var entity_counter: int = 0
var __id: int = -1

@export var stats: Stats = Stats.new()

var sprite: Sprite2D
var body: CharacterBody2D
var state: State

func _init() -> void:
	# Id setting.
	__id = entity_counter
	entity_counter += 1
	
	# Set component children.
	_set_children()


func _ready() -> void:
	# Set state.
	state = State.new(stats)


func _notification(what: int) -> void:
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		update_configuration_warnings()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	var children = get_children()
	
	if not stats:
		warnings.append("Stats is not assigned.")
	if not children.any(func(c): return c is Sprite2D):
		warnings.append("Sprite2D is not assigned.")
	if not children.any(func(c): return c is CharacterBody2D):
		warnings.append("CharacterBody2D is not assigned.")
	
	return warnings


func _set_children():
	for c in get_children():
		if not sprite and c is Sprite2D:
			sprite = c
		elif not body and c is CharacterBody2D:
			body = c


func attacked(amount: float):
	if state.receive_damage(amount):
		die()


func apply_damage(ente: Entity):
	var attack_damage = state.curr_damage
	ente.attacked(attack_damage)


func die():
	print("%s was killed..." % [name])
	queue_free()
