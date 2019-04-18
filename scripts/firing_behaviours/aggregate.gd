extends Node2D

signal finished

export var is_cyclical = false
var children = []
var index = 0

func _ready():
	assert(get_child_count() > 0)
	for node in get_children():
		children.append(node)
		node.connect('ttl_expired', self, '_start_next_behaviour')
		remove_child(node)
	add_child(children[index])

func _start_next_behaviour(expired_node):
	remove_child(children[index])
	index = (index + 1) % children.size()
	if not is_cyclical and index == 0:
		emit_signal('finished')
	else:
		add_child(children[index])