@tool
class_name Level
extends Node2D

var path: Path
var waves: Waves
var curr_round_index: int = 0

func _ready() -> void:
	# Set component children.
	_set_children()
	
	start()


func _notification(what: int) -> void:
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		update_configuration_warnings()


## TODO: This does the same as in Entity,
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	var children = get_children()
	
	if not children.any(func(c): return c is Path):
		warnings.append("Path is not assigned.")
	if not children.any(func(c): return c is Waves):
		warnings.append("Waves is not assigned.")
	
	return warnings


func _set_children():
	for c in get_children():
		if not path and c is Path:
			path = c
		if not waves and c is Waves:
			waves = c


func start():
	var curr_round = waves.rounds[curr_round_index]
	for ente in curr_round:
		var times = curr_round[ente]
		
		for i in range(times):
			var enemy: Enemy = waves.enemies[ente].instantiate()
			
			await get_tree().create_timer(1.5).timeout
			
			self.add_child(enemy)
			path.start_walk(enemy)
