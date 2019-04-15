extends "res://scripts/firing_behaviours/ring.gd"

export(int) var k = 4

func _shoot():
	for i in range(0, bullet_count):
		var angle = i * spacing_angle
		var bullet = _create_bullet()
		var konst = cos(k*angle) * 100
		var cosAngle = cos(angle)
		var sinAngle = sin(angle)
		var vec = Vector2(konst*cosAngle,konst*sinAngle)
		bullet.position += vec
		bullet.launch(vec.normalized(), launch_speed)
		_attach_to_root(bullet)
