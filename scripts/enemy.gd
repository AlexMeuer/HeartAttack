extends 'res://scripts/drivable_entity.gd'
class_name Enemy

signal on_death

export(int) var health = 1

func _ready():
	# TODO: Perhaps destroy after a second instead of immediately?
	$VisibilityNotifier2D.connect('screen_exited', self, 'destroy')

func _physics_process(delta):
	thrust(delta)
	turn_right(delta)
	._physics_process(delta)

func _on_collision(collision):
	#print(name+' had a collision with '+collision.get_collider().name)
	take_damage(1)

func on_receive_collision(other):
	take_damage(1)

func take_damage(amount):
	health -= amount
	if health <= 0:
		die()

func die():
	emit_signal('on_death')
	destroy()