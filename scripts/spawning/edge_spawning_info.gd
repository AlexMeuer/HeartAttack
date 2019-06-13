extends Reference

var start_position: Vector2
var cascade_direction: Vector2
var travel_direction: Vector2

func _init(start_position_: Vector2, cascade_direction_: Vector2, travel_direction_: Vector2):
	start_position = start_position_
	cascade_direction = cascade_direction_
	travel_direction = travel_direction_

func get_cascade_position(index: int, spacing: float) -> Vector2:
	print(start_position + (cascade_direction * index * spacing))
	return start_position + (cascade_direction * index * spacing)

func place_into_cascade(entity: KinematicEntity, index: int, spacing: float) -> KinematicEntity:
	entity.set_direction(travel_direction)
	entity.set_position(get_cascade_position(index, spacing))
	return entity
