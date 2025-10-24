class_name TowerGround
extends Ground

signal hitted(body: CharacterBody2D)

func _ready() -> void:
	super()
	_set_tower()
	body_entered.connect(hitted.emit)


func _set_tower():
	var texture = load("res://assets/towers/main.png")
	var sprite_tower = Sprite2D.new()
	sprite_tower.texture = texture 
	sprite_tower.position.y -= 32.5
	sprite_tower.z_index += 1
	add_child(sprite_tower)
