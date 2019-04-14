extends "res://scripts/firing_behaviours/base.gd"

export var angle_increment = PI * 0.1
export var angle = 0

func _shoot():
	var bullet = _create_bullet()
	bullet.launch(Vector2(cos(angle),sin(angle)), self.launch_speed)
	angle += angle_increment
	_attach_to_root(bullet)
