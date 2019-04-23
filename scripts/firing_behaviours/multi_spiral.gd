extends "res://scripts/firing_behaviours/spiral.gd"

export(int) var spiral_count = 2
var spacing_angle = 0

func _ready():
	._ready()
	assert(spiral_count > 0)
	spacing_angle = 2 * PI / spiral_count

func _shoot():
	var starting_angle = angle
	for i in range(0, spiral_count):
		._shoot()
		angle += spacing_angle
	angle = starting_angle + angle_increment # Prevents drift over time
