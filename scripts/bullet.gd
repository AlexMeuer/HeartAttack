extends 'res://scripts/kinematic_entity.gd'

const REFLECTED_COLLISION_LAYER = 6

signal reflect_off_shield

func launch(direction, speed = 1):
	set_motion(direction * speed)
	$VisibilityNotifier2D.connect('screen_exited', self, 'destroy')

func _on_collision(collision):
	._on_collision(collision)
	var other = collision.get_collider()
	
	if other.has_method('on_receive_collision'):
		other.on_receive_collision(self)
	
	if other.name == 'Shield':
		_reflect(collision)
	else:
		destroy()

func _reflect(collision):
	_motion = _motion.bounce(collision.normal) * 4
	translate(collision.remainder.bounce(collision.normal))
	set_collision_layer_bit(REFLECTED_COLLISION_LAYER, true) 
	emit_signal('reflect_off_shield')
