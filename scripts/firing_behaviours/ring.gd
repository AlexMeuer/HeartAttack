extends "res://scripts/firing_behaviours/base.gd"

export var bullet_count = 12
var spacing_angle = 0

func _ready():
	spacing_angle = 2 * PI / bullet_count

func _shoot():
	var angle = 0
	for i in range(0, bullet_count):
		var bullet = _create_bullet()
		bullet.launch(Vector2(cos(angle),sin(angle)), self.launch_speed)
		angle += spacing_angle
		_attach_to_root(bullet)
