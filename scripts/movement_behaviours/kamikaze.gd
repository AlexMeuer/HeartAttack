extends "res://scripts/movement_behaviours/base.gd"

onready var _target = get_tree().get_nodes_in_group('player')[0] # TODO: use _set_target() instead.

func _set_target(target: Node2D):
	_target = target

func _physics_process(delta):
	var parent = get_parent()
	parent.thrust(delta)
	parent.turn_toward(_target.get_global_position(), delta)
