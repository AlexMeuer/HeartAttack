extends "res://scripts/movement_behaviours/base.gd"
class_name MovementBehaviourZigZag

export (float)var zig_time = 1
export (float)var zag_time = 1
export var reflect_vector = Vector2(0, 1)

var zigging = true
onready var timer = get_node_or_null('Timer')

func _ready():
	assert(reflect_vector.length() > 0)
	reflect_vector = reflect_vector.normalized()
	if not timer:
		timer = Timer.new()
		timer.name = 'Timer'
		timer.connect("timeout", self, "_change_zig_zag")
		add_child(timer)
	timer.set_one_shot(true)
	timer.set_paused(false)
	start_timer()

func start_timer():
	timer.start(zig_time if zigging else zag_time)

func _change_zig_zag():
	zigging = not zigging
	var parent = get_parent()
	parent.velocity = parent.velocity.reflect(reflect_vector)
	start_timer()
