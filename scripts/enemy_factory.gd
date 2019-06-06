extends Node
class_name EnemyFactory

enum EnemyType {
	Kamikaze,
	Straight,
}

const _defaultEnemy = preload("res://scenes/enemies/kamikaze.tscn")
const _enemyBlueprints = {
	EnemyType.Kamikaze: _defaultEnemy,
	EnemyType.Straight: preload("res://scenes/enemies/straight.tscn"),
}

class SpawningPipeline:
	var _enemy: Enemy
	
	func _init(enemy: Enemy):
		_enemy = enemy
	
	func at(x: float, y: float):
		_enemy.set_position(Vector2(x, y))
		return self
	
	func travelling(direction: Vector2, speed: float):
		return with_velocity(direction.normalized() * speed)
	
	func with_velocity(velocity: Vector2):
		_enemy.set_velocity(velocity)
		return self
	
	func done():
		return _enemy

func spawn(type: int):
	return SpawningPipeline.new(
		_enemyBlueprints.get(type, _defaultEnemy).instance()
	)