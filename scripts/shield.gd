extends KinematicEntity

export(PackedScene) var projectile

onready var _anim_player = $AnimationPlayer

func on_laser_hit():
	if _anim_player.is_playing():
		if _anim_player.current_animation == 'LaserWindup':
			_anim_player.clear_queue()
			_anim_player.play('LaserFire')
		_anim_player.queue('LaserWindup')
	else:
		_anim_player.play('LaserWindup')
	_anim_player.queue('LaserFire')

func fire_laser():
	var node = projectile.instance()
	node.global_position = global_position
	node.translate(Vector2(0, -100))
	node.rotation = rotation
	get_tree().get_root().add_child(node)