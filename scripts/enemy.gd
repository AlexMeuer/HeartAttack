extends 'res://scripts/kinematic_entity.gd'

export var bullet_prototype = preload("res://scenes/bullet.tscn")
export var gun_cooldown = 0.1
var time_since_shoot = 0
var angle = 0

func _physics_process(delta):
	time_since_shoot += delta
	if time_since_shoot >= gun_cooldown:
		time_since_shoot = 0
		var bullet = bullet_prototype.instance()
		bullet.position = position
		bullet.launch(Vector2(cos(angle),sin(angle)), 200)
		angle += PI * 0.1
		get_parent().add_child(bullet)
