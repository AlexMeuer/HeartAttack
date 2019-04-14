extends 'res://scripts/kinematic_entity.gd'

const SPEED = 250

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		_motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		_motion.x = -SPEED
	else:
		_motion.x = 0
	
	if Input.is_action_pressed("ui_up"):
		_motion.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		_motion.y = SPEED
	else:
		_motion.y = 0
	
	._physics_process(delta)

func on_receive_collision(other):
	pass