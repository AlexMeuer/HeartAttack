extends Node
class_name EnemyFactory

var _base_prototype = preload("res://scenes/enemy.tscn")

func create_basic(firing: FiringBehaviourBase, movement: MovementBehaviourBase):
	assert(movement != null) # Firing can be null but movement cannot.
	var enemy = _base_prototype.instance()
	if firing:
		enemy.add_child(firing)
	enemy.add_child(movement)
	return enemy
