extends "res://scripts/movement_behaviours/base.gd"
class_name MovementBehaviourStrafe

export (float)var time = 1
onready var timer = get_node_or_null('Timer')

func _ready():
	if not timer:
		timer = Timer.new()
		timer.name = 'Timer'
		timer.connect("timeout", self, "_change_direction")
		add_child(timer)
	timer.set_one_shot(false)
	timer.set_paused(false)
	timer.start(time)

func _change_direction():
	var parent = get_parent()
	parent.velocity = -parent.velocity
