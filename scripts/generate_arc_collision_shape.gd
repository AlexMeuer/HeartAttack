extends CollisionShape2D

# Requires Convex/ConcavePolgonShape2D as the shape resource.

export var num_points = 10
export var step = 3
export var radius = 100

func _ready():
	var points = PoolVector2Array()
	for i in range(0, num_points * step, step):
		points.append(Vector2(-abs(sin(i)) * radius, -abs(cos(i)) * radius))
	get_shape().set_point_cloud(points)
