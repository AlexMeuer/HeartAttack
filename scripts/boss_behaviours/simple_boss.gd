extends 'res://scripts/kinematic_entity.gd'

var gun = null
const GUN_NODE_NAME = 'FiringBehaviour'

func _ready():
	if has_node(GUN_NODE_NAME):
		gun = $FiringBehaviour
	else:
		gun = Node2D.new()
		gun.name = GUN_NODE_NAME
		add_child(gun)
	
