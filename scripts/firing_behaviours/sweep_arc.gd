extends "res://scripts/firing_behaviours/spiral.gd"
class_name FiringBehaviourSweepArc

export (float) var start_arc_angle = 0
export (float) var end_arc_angle = PI

func _shoot():
	._shoot()
	if angle >= end_arc_angle or angle <= start_arc_angle:
		angle_increment *= -1
