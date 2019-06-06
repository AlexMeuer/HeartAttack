extends 'res://scripts/drivable_entity.gd'
class_name Enemy

const WEAPON_ACTIVATION_DELAY = 1.5

signal on_death

export(int) var health = 1

onready var firing_behaviour = get_node_or_null('FiringBehaviour')

func _ready():
	# TODO: Perhaps destroy after a second instead of immediately?
	var visibility_notifier = $VisibilityNotifier2D
	
	if firing_behaviour:
		firing_behaviour.set_process(false)
		visibility_notifier.connect('screen_entered', self, '_activate_weapons')
		
	visibility_notifier.connect('screen_exited', self, 'destroy')

func _activate_weapons():
	yield(get_tree().create_timer(WEAPON_ACTIVATION_DELAY), 'timeout')
	firing_behaviour.set_process(true)

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