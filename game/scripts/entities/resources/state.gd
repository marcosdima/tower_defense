class_name State

var base_stats: Stats

var curr_speed: float
var curr_health: float
var curr_damage: float

func _init(base: Stats) -> void:
	base_stats = base
	curr_speed = base.speed
	curr_health = base.health
	curr_damage = base.damage


func receive_damage(amount: float) -> bool:
	curr_health -= amount
	return curr_health <= 0.0


func refresh_stats(targets: Array = Stats.TYPES.values()):
	var types = Stats.TYPES
	for target in targets:
		match target:
			types.HEALTH:
				curr_health = min(curr_health, base_stats.health)
			types.SPEED:
				curr_speed = base_stats.speed
			types.DAMAGE:
				curr_damage = base_stats.damage
