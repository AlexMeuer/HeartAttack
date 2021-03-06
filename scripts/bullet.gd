extends 'res://scripts/kinematic_entity.gd'

class_name Bullet

const REFLECTED_COLLISION_LAYER = 6

signal reflect_off_shield

func launch(direction, speed = 1):
	velocity = direction * speed
	$VisibilityNotifier2D.connect('screen_exited', self, 'destroy')

func _on_collision(collision):
	._on_collision(collision)
	if collision.get_collider().name == 'Shield':
		_reflect(collision)
	else:
		destroy()

func _reflect(collision):
	velocity = (velocity.bounce(collision.normal) * 4).clamped(600)
	move_and_collide(collision.remainder.bounce(collision.normal))
	set_collision_layer_bit(REFLECTED_COLLISION_LAYER, true)
	emit_signal('reflect_off_shield')
