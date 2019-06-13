extends Node
class_name EnemyFactory

enum EnemyType {
	KAMIKAZE,
	STRAIGHT,
	SPIRAL_SHOOTER,
}

const _enemy_blueprints = {
	EnemyType.KAMIKAZE: preload("res://scenes/enemies/kamikaze.tscn"),
	EnemyType.STRAIGHT: preload("res://scenes/enemies/base.tscn"),
	EnemyType.SPIRAL_SHOOTER: preload("res://scenes/enemies/spiral_shooter.tscn"),
}

class CascadeSpawnArgs:
	var edge: int setget set_edge
	var edge_info setget _dont_set_edge_info
	var blueprint: PackedScene
	var amount: int = -1 setget, get_amount
	var space_between: float = -1 setget ,get_spacing
	var delay_between: float = 0.5
	var reverse: bool = false
	var instance_modifier # TODO - a funcref to modify instances once they're created
	
	func _init(edge_: int, enemy_type: int):
		edge = edge_
		edge_info = Edge.get_edge_spawning_info(edge_)
		assert(edge_info is Edge.EdgeSpawningInfo)
		if edge_info == null:
			push_error('\'%d\' is not a valid edge! (See Edge enum)' % edge)
		blueprint = _enemy_blueprints.get(enemy_type)
		if blueprint == null:
			push_error('\'%d\' is not a valid enemy type! (See EnemyType enum)' % enemy_type)
	
	func instantiate_into_cascade(index: int):
		return edge_info.place_into_cascade(blueprint.instance(), amount - index if reverse else index, get_spacing())
	
	func set_edge(new_edge: int):
		var new_edge_info = Edge.get_edge_spawning_info(new_edge)
		assert(new_edge_info is Edge.EdgeSpawningInfo)
		if new_edge_info == null:
			push_error('\'%d\' is not a valid edge! (See Edge enum)' % edge)
		else:
			edge = new_edge
			edge_info = new_edge_info
	
	func _dont_set_edge_info(value):
		push_error('Edge info should only be set internally! Tried to set as: '+str(value))
	
	func get_amount():
		if amount > 0:
			return amount
		assert(space_between >= 0)
		if edge == Edge.TOP or edge == Edge.BOTTOM:
			return int(Global.SCREEN_WIDTH / space_between)
		else:
			return int(Global.SCREEN_HEIGHT / space_between)
	
	func get_spacing():
		if space_between >= 0:
			return space_between
		assert(amount > 0)
		if edge == Edge.TOP or edge == Edge.BOTTOM:
			return Global.SCREEN_WIDTH / float(amount+1)
		else:
			return Global.SCREEN_HEIGHT / float(amount+1)

func spawn_cascade(args: CascadeSpawnArgs):
	assert(args)
	var spacing = args.space_between
	for i in range(1, args.amount+1):
		add_child(args.instantiate_into_cascade(i))
		if args.delay_between > 0:
			yield(get_tree().create_timer(args.delay_between), 'timeout')