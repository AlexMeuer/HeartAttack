extends Node2D

class_name Level

var enemy_prototype = preload("res://scenes/enemy.tscn")

func _spawn(position):
	var enemy = enemy_prototype.instance()
	enemy.position = position
	add_child(enemy)
