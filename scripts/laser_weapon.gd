extends Node2D
class_name LaserWeapon

signal firing

export(float) var cooldown_duration = 1.0
export(float) var target_lead_time = 0.5

var crosshair_interpolation := 0.01
onready var _crosshair := $Crosshair
onready var _laserLine := $LaserLine
onready var _crosshair_animator = $Crosshair/AnimationPlayer
var _target: KinematicEntity
var _is_tracking := true
var _is_firing := false
var _last_raytrace_result: Dictionary

func _ready():
	yield(get_tree().create_timer(10), 'timeout')
	_crosshair_animator.stop()
	track($DummyTarget)

func track(target: Node2D):
	if (_target == target):
		return
		
	if (_target):
		clear_target()
		
	_target = target
	_target.connect('tree_exiting', self, 'clear_target')
	
	_crosshair_animator.queue('WarmUp')

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
	_crosshair_animator.play("CoolDown")
	# Wait for the cooldown duration and _then_ queue the warm up animation.
	get_tree().create_timer(cooldown_duration).connect("timeout", _crosshair_animator, 'queue', ['WarmUp'], CONNECT_ONESHOT)
	
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
		var lead_position = _target.global_position + (_target.velocity * target_lead_time)
		_crosshair.global_position = _crosshair.global_position.linear_interpolate(lead_position, crosshair_interpolation * delta)
	
	if _is_firing:
		_update_laser_line()

# Should only ever be called from `_physics_process(delta)` because raycasting is involved.
func _update_laser_line():
	# https://docs.godotengine.org/en/3.1/tutorials/physics/ray-casting.html
	var space_state = get_world_2d().direct_space_state
	_last_raytrace_result = space_state.intersect_ray(get_global_position(), _crosshair.global_position, [self], Global.COLLISION_LAYER_SHIELD)
	
	if _last_raytrace_result.empty():
		_laserLine.set_point_position(1, _crosshair.position)
		return
	
	_laserLine.set_point_position(1, _last_raytrace_result.position)

func _on_animation_finished(anim_name):
	if anim_name == 'LaserBlast':
		_is_firing = false
