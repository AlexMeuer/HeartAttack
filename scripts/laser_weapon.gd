extends Node2D
class_name LaserWeapon

signal firing

export var crosshair_interpolation = 0.01
onready var crosshair = $Crosshair
onready var laserLine = $LaserLine
onready var animator = $AnimationPlayer
var _target: Node2D
var _is_tracking = true
var _is_firing = false

func track(target: Node2D):
	if (_target == target):
		return
		
	if (_target):
		clear_target()
		
	_target = target
	_target.connect('tree_exiting', self, 'clear_target')
	
	var crosshair_animator = $Crosshair/AnimationPlayer
	crosshair_animator.stop()
	crosshair_animator.play('WarmUp')

func clear_target():
	if (!_target):
		return
	_target.disconnect('tree_exiting', self, 'clear_target')
	_target = null

func fire():
	if _is_firing:
		push_warning(name+': Cannot fire, already firing!')
		return
	_is_firing = true
	emit_signal("firing")

func deal_damage():
	push_warning(name+'::deal_damage() is not implemented.')

func pause_tracking():
	_is_tracking = false

func resume_tracking():
	_is_tracking = true

func _process(delta):
	if !_target or !_target.is_inside_tree():
		return
	
	if _is_tracking:
		crosshair.set_global_position(crosshair.get_global_position().linear_interpolate(_target.get_global_position(), crosshair_interpolation))
		if _is_firing:
			laserLine.set_point_position(1, crosshair.get_position())

func _on_animation_finished(anim_name):
	if anim_name == 'LaserBlast':
		_is_firing = false
