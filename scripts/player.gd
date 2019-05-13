extends 'res://scripts/kinematic_entity.gd'
class_name Player

signal health_changed
signal damaged

const SPEED = 250
var health = 5
onready var shield_controller = $ShieldController

func _ready():
	emit_signal('health_changed', health)

func on_receive_collision(other):
	health -= 1
	emit_signal('health_changed', health)
	emit_signal('damaged')

func on_left_analog_changed(force):
	set_velocity(Vector2(force.x, -force.y) * SPEED) 

func on_right_analog_changed(force):
	if force.length() > 0:
		shield_controller.look_at(position + Vector2(force.y, force.x))
