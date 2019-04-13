extends KinematicBody2D

var motion = Vector2()

func _physics_process(delta):
	move_and_slide(motion)

func launch(direction, speed = 1, ttl = 10):
	motion = direction * speed
	var timer = Timer.new()
	timer.connect("timeout", self, "_on_ttl_expired") 
	add_child(timer)
	timer.start(ttl)

func _on_ttl_expired():
	get_parent().remove_child(self)
	queue_free()