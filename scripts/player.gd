extends 'res://scripts/kinematic_entity.gd'

const SPEED = 250

func on_receive_collision(other):
	pass

func on_left_analog_changed(force):
	_motion = Vector2(force.x, -force.y) * SPEED

func on_right_analog_changed(force):
	if force.length() > 0:
		$ShieldController.look_at(position + Vector2(force.y, force.x))
