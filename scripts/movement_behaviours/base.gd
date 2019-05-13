extends Node
class_name MovementBehaviourBase

func _ready():
	assert(get_parent() is DrivableEntity) # We depend on the parent being a KinematicEntity.
