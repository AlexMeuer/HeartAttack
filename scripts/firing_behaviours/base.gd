extends Node2D

signal ttl_expired

export(PackedScene) var bullet_prototype = preload('res://scenes/bullet.tscn')
export(float) var cooldown = 1
export var launch_speed = 200
export(int) var ttl = 0
onready var time_since_shoot = 0

func _ready():
	assert(bullet_prototype != null)
	if ttl > 0:
		var timer = get_node_or_null('Timer')
		if timer:
			timer.stop()
		else:
			timer = Timer.new()
			timer.name = 'Timer'
			add_child(timer)
		timer.connect("timeout", self, "_on_ttl_expired")
		timer.start(ttl)
		timer.set_paused(false)

func _process(delta):
	time_since_shoot += delta
	if time_since_shoot >= cooldown:
		time_since_shoot = 0
		_shoot()

func _create_bullet():
	var bullet = bullet_prototype.instance()
	bullet.position = global_position
	return bullet

func _shoot():
	pass # Override me
	
func _attach_to_root(node):
	get_tree().get_root().add_child(node)
	
func _on_ttl_expired():
	emit_signal('ttl_expired')
