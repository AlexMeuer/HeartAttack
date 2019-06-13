extends "res://scripts/spawning/enemy_factory.gd"

func _ready():
	while(true):
		var cascada := CascadeSpawnArgs.new(Edge.TOP, EnemyType.STRAIGHT)
		cascada.amount = 10
		
		yield(get_tree().create_timer(2), 'timeout') # Wait for 2 seconds
		spawn_cascade(cascada)
		
		yield(get_tree().create_timer(5), 'timeout')
		cascada.edge = Edge.LEFT
		spawn_cascade(cascada)
		
		yield(get_tree().create_timer(5), 'timeout')
		cascada.delay_between = 0.1
		cascada.amount = 20
		cascada.reverse = true
		cascada.edge = Edge.TOP
		spawn_cascade(cascada)
		
		yield(get_tree().create_timer(5), 'timeout')
		cascada.amount = 10
		cascada.reverse = false
		spawn_cascade(cascada)