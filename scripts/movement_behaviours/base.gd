extends Node
class_name MovementBehaviourBase

func _ready():
	assert(get_parent() is KinematicEntity) # We depend on the parent being a KinematicEntity.
