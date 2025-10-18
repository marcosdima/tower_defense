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


func apply_damage(amount: float) -> bool:
	curr_health -= amount
	return curr_health <= 0.0


func refresh_stats():
	curr_speed = base_stats.speed
	curr_damage = base_stats.damage
	curr_health = min(curr_health, base_stats.health)
