extends Node2D

const ROTATION_SPEED = 1

func _process(delta):
	if Input.is_key_pressed(KEY_Q):
		rotate(-ROTATION_SPEED * delta)
	elif Input.is_key_pressed(KEY_E):
		rotate(ROTATION_SPEED * delta)
