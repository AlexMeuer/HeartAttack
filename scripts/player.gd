extends 'res://scripts/kinematic_entity.gd'

signal health_changed

const SPEED = 250
var health = 5

func _ready():
	emit_signal('health_changed', health)

func on_receive_collision(other):
	health -= 1
	emit_signal('health_changed', health)

func on_left_analog_changed(force):
	_motion = Vector2(force.x, -force.y) * SPEED

func on_right_analog_changed(force):
	if force.length() > 0:
		$ShieldController.look_at(position + Vector2(force.y, force.x))
