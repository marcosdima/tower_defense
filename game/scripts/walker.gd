extends CharacterBody2D
class_name Walker

@export var speed = 100.0

var path: PathController
var path_follower: PathFollow2D = PathFollow2D.new()

func _process(delta):
	if path and path_follower:
		var distance = path_follower.progress + (speed * delta)
		if path.ended(distance):
			self.queue_free()
		else:
			walk_distance(distance)


func _exit_tree():
	if path_follower and path_follower.get_parent():
		path_follower.queue_free()


func set_path(new_path: PathController):
	if path and path_follower.get_parent() == path:
		path.remove_child(path_follower)
	path = new_path
	path_follower.progress = 0
	path.add_child(path_follower)


func walk_distance(d: float):
	path_follower.progress = d
	self.global_position = path_follower.global_position
