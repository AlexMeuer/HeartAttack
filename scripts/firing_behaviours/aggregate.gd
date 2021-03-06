extends Node2D
class_name FiringBehaviourAggregate

signal finished

export(int) var repeat_count = 0
onready var repeats_so_far = 0
onready var index = 0
var children = []

func _ready():
	assert(get_child_count() > 0)
	for node in get_children():
		children.append(node)
		node.connect('ttl_expired', self, '_start_next_behaviour')
		remove_child(node)
	add_child(children[index])

func _start_next_behaviour():
	remove_child(children[index])
	index = (index + 1) % children.size()
	if _should_continue():
		add_child(children[index])
	else:
		emit_signal('finished')

func _should_continue():
	if index != 0 or repeat_count < 0:
		return true
	if repeat_count == 0:
		return false
	repeats_so_far += 1
	return repeats_so_far < repeat_count
