extends KinematicBody2D
class_name KinematicEntity

export var _velocity = Vector2()
export var face_travel_direction = true

func _physics_process(delta):
	var collision = move_and_collide(_velocity * delta)
	if collision:
		_on_collision(collision)
	if face_travel_direction:
		look_at(global_position+get_velocity())

func _on_collision(collision):
	#print(name+' had a collision with '+collision.get_collider().name)
	var other = collision.get_collider()
	if other.has_method('on_receive_collision'):
		other.on_receive_collision(self)

func on_receive_collision(other):
	pass
	
func set_velocity(velocity):
	_velocity = velocity

func get_velocity():
	return _velocity

func set_direction(direction):
	set_velocity(direction.normalized() * get_speed())
	
func get_speed():
	return get_velocity().length()

func get_forward():
	if get_speed() <= 0:
		return Vector2.RIGHT
	return get_velocity().normalized()

func destroy():
	# It turns out queue_free is enough. Removing the child like this can cause the game to hard-crash!
	#get_parent().remove_child(self)
	queue_free()