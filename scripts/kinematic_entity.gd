extends KinematicBody2D
class_name KinematicEntity

export var _motion = Vector2()

func _physics_process(delta):
	var collision = move_and_collide(_motion * delta)
	if collision:
		_on_collision(collision)
	look_at(global_position+get_motion())

func _on_collision(collision):
	#print(name+' had a collision with '+collision.get_collider().name)
	var other = collision.get_collider()
	if other.has_method('on_receive_collision'):
		other.on_receive_collision(self)

func on_receive_collision(other):
	pass
	
func set_motion(velocity):
	_motion = velocity

func get_motion():
	return _motion
	
func get_speed():
	return _motion.length()

func destroy():
	# It turns out queue_free is enough. Removing the child like this can cause the game to hard-crash!
	#get_parent().remove_child(self)
	queue_free()