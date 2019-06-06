extends Node

const kamikaze_enemy_prototype = preload("res://scenes/enemies/kamikaze.tscn")
const foo_enemy_prototype = preload("res://scenes/enemy.tscn")

onready var factory = $"/root/EnemyFactory"

func _ready():
	for i in range(100):
		yield(get_tree().create_timer(1), 'timeout')
		add_child(factory.spawn(factory.EnemyType.Straight).at(800+randi()%100, -100).travelling(Vector2.DOWN, 100).done())
		yield(get_tree().create_timer(0.5), 'timeout')
		add_child(factory.spawn(factory.EnemyType.Straight).at(500+randi()%100, -100).travelling(Vector2.DOWN, 120).done())
	