extends Node2D

signal ttl_expired

export(PackedScene) var bullet_prototype = preload('res://scenes/bullet.tscn')
export(float) var cooldown = 1
export var launch_speed = 200
export(int) var ttl = 0
var time_since_shoot = 0
var timer = null

func _ready():
	assert(bullet_prototype != null)
	if ttl > 0:
		var previous_timer = get_node_or_null('Timer')
		if previous_timer:
			print('%s: Clearing previous timer')
			remove_child(previous_timer)
			previous_timer.queue_free()
		timer = Timer.new()
		timer.name = 'Timer'
		timer.connect("timeout", self, "_on_ttl_expired") 
		add_child(timer)
		timer.start(ttl)

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
	remove_child(timer)
	timer.queue_free()
	emit_signal('ttl_expired', self)
