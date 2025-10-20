class_name Walker
extends PathFollow2D

var path: Path
var buddy: Entity

func _init(ente: Entity) -> void:
	buddy = ente


func _process(delta):
	if path and is_instance_valid(buddy):
		var distance = progress + (buddy.state.curr_speed * delta)
		if path.ended(distance):
			path.remove_child(self)
		else:
			walk_distance(distance)


func set_path(new_path: Path):
	if path and get_parent() == path:
		path.remove_child(self)
	path = new_path
	progress = 0
	path.add_child(self)


func walk_distance(d: float):
	progress = d
	buddy.global_position = global_position
