extends Path2D

func spawn_something(some: Walker):
	self.add_child(some)
	some.walk.connect(
		func(distance: float):
			validate_walk(some, distance)
	)

func validate_walk(walker: Walker, distance: float):
	var length = curve.get_baked_length()
	if distance >= length:
		walker.queue_free()
		print(walker.name + ' reached the end!')
	else:
		walker.progress = distance
