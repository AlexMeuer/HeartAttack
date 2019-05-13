extends "res://scripts/movement_behaviours/base.gd"

onready var _target = get_tree().get_nodes_in_group('player')[0] # TODO: use _set_target() instead.

# TODO: Don't do hard lock-on. Right now, we can turn on a dime.

func _set_target(target: Node2D):
	_target = target

func _process(delta):
	var parent: KinematicEntity = get_parent()
	var displacement = _target.get_position() - parent.get_position()
	parent.set_motion(displacement.normalized() * parent.get_speed())
