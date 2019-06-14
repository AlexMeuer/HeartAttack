extends "res://scripts/spawning/enemy_factory.gd"

onready var _player = $Player

func _ready():
	while(true):
		var cascada := CascadeSpawnArgs.new(Edge.TOP, EnemyType.SPIRAL_SHOOTER)
		cascada.amount = 10
		
		var visitor = funcref(self, '_visit')
		
		yield(get_tree().create_timer(2), 'timeout') # Wait for 2 seconds
		spawn_cascade(cascada, visitor)
		
		yield(get_tree().create_timer(5), 'timeout')
		cascada.edge = Edge.LEFT
		spawn_cascade(cascada)
		
		yield(get_tree().create_timer(5), 'timeout')
		cascada.delay_between = 0.1
		cascada.amount = 20
		cascada.reverse = true
		cascada.edge = Edge.TOP
		spawn_cascade(cascada, visitor)
		
		yield(get_tree().create_timer(5), 'timeout')
		cascada.amount = 10
		cascada.reverse = false
		spawn_cascade(cascada, visitor)

func _visit(instance: Enemy):
	instance.set_direction(_player.position - instance.position)