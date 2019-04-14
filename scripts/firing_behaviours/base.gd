extends Node2D

export(PackedScene) var bullet_prototype = preload('res://scenes/bullet.tscn')
export(float) var cooldown = 1
export var launch_speed = 200
var time_since_shoot = 0

func _ready():
	assert(bullet_prototype != null)

func _process(delta):
	time_since_shoot += delta
	if time_since_shoot >= cooldown:
		time_since_shoot = 0
		_shoot()

func _create_bullet():
	var bullet = bullet_prototype.instance()
	bullet.position = global_position
	return bullet

func _shoot():
	pass # Override me
	
func _attach_to_root(node):
	get_tree().get_root().add_child(node)