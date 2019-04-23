extends "res://scripts/firing_behaviours/base.gd"

export var bullet_count = 12
var spacing_angle = 0

func _ready():
	._ready()
	spacing_angle = 2 * PI / bullet_count

func _shoot():
	for i in range(0, bullet_count):
		var angle = i * spacing_angle
		var bullet = _create_bullet()
		bullet.launch(Vector2(cos(angle),sin(angle)), launch_speed)
		_attach_to_root(bullet)
