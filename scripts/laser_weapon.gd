extends Node2D
class_name LaserWeapon

signal firing

export var crosshair_interpolation := 0.01
onready var crosshair := $Crosshair
onready var laserLine := $LaserLine
onready var animator := $AnimationPlayer
onready var _target: Node2D = $DummyTarget
var _is_tracking := true
var _is_firing := false
var _last_raytrace_result: Dictionary

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
	push_warning(name+'::deal_damage() is not fully implemented.')
	if _last_raytrace_result.empty():
		return
		
	var collider := _last_raytrace_result.collider as Object
	
	if collider == null:
		push_error('Laser hit a non-object! '+str(_last_raytrace_result))
	elif collider.has_method('on_laser_hit'):
		collider.on_laser_hit()
	elif collider.has_method('take_damage'):
		collider.take_damage()
	else:
		push_error(name+' has no way of reacting to laser hits!')

func pause_tracking():
	_is_tracking = false

func resume_tracking():
	_is_tracking = true

func _physics_process(delta):
	if !_target or !_target.is_inside_tree():
		return
	
	if _is_tracking:
		crosshair.set_global_position(crosshair.global_position.linear_interpolate(_target.global_position, crosshair_interpolation * delta))
	
	if _is_firing:
		_update_laser_line()

# Should only ever be called from `_physics_process(delta)` because raycasting is involved.
func _update_laser_line():
	# https://docs.godotengine.org/en/3.1/tutorials/physics/ray-casting.html
	var space_state = get_world_2d().direct_space_state
	_last_raytrace_result = space_state.intersect_ray(global_position, crosshair.global_position, [self], Global.COLLISION_LAYER_SHIELD)
	
	if _last_raytrace_result.empty():
		laserLine.set_point_position(1, crosshair.position)
		return
	
	laserLine.set_point_position(1, _last_raytrace_result.position)

func _on_animation_finished(anim_name):
	if anim_name == 'LaserBlast':
		_is_firing = false
