class_name Walker
extends PathFollow2D

enum Direction {
	Left,
	Right,
}

var path: Path
var buddy: Enemy
var is_walking: bool = false

func _init(ente: Entity) -> void:
	buddy = ente


func _process(delta):
	if path and is_instance_valid(buddy):
		var distance = progress + (buddy.state.curr_speed * delta)
		
		if path.ended(distance):
			leave_path()
			return
		
		walk_distance(distance)
		
		if not is_walking:
			is_walking = true


func set_path(new_path: Path):
	path = new_path
	progress = 0
	path.add_child(self)


func leave_path():
	if !path:
		return
	path.remove_child(self)
	path.handle_end_path(buddy)


func walk_distance(d: float):
	progress = d
	buddy.global_position = global_position
