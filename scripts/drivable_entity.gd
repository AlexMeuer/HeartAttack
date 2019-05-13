extends "res://scripts/kinematic_entity.gd"
class_name DrivableEntity

export var _MAX_SPEED = 50
export var _THRUST = 10
export var _TURN_SPEED = PI * 0.1

func thrust(delta):
	var new_vel = get_velocity() + get_forward() * _THRUST * delta
	set_velocity(new_vel.clamped(_MAX_SPEED))

func brake(delta):
	if get_speed() <= 0:
		return
		
	var decel = get_forward() * _THRUST * delta
	
	if get_speed() - decel.length() < 0:
		set_velocity(Vector2())
	else:
		_velocity -= get_forward() * _THRUST * delta

func turn_toward(point, delta):
	var displacement = get_global_position() - point
	var perp_dot = displacement.normalized().tangent().dot(get_forward())
	if perp_dot > 0:
		turn_left(delta)
	else:
		turn_right(delta)

func turn_left(delta):
	turn(-_TURN_SPEED * delta)

func turn_right(delta):
	turn(_TURN_SPEED * delta)

func turn(radians):
	set_velocity(get_speed() * get_forward().rotated(radians))