extends KinematicBody2D

var _motion = Vector2()

func _physics_process(delta):
	var collision = move_and_collide(_motion * delta)
	if collision:
		_on_collision(collision)

func _on_collision(collision):
	print(name+' had a collision with '+collision.get_collider().name)

func on_receive_collision(other):
	pass
	
func set_motion(velocity):
	_motion = velocity

func destroy():
	get_parent().remove_child(self)
	queue_free()