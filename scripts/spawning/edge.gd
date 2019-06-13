extends Node

const EdgeSpawningInfo = preload('res://scripts/spawning/edge_spawning_info.gd')

enum {
	LEFT,
	TOP,
	RIGHT,
	BOTTOM
}

const EDGE_MARGIN := 100.0

var _edge_spawning_infos = {
	LEFT: EdgeSpawningInfo.new(Vector2.LEFT * EDGE_MARGIN, Vector2.DOWN, Vector2.RIGHT),
	TOP: EdgeSpawningInfo.new(Vector2.UP * EDGE_MARGIN, Vector2.RIGHT, Vector2.DOWN),
	RIGHT: EdgeSpawningInfo.new(Vector2(Global.SCREEN_WIDTH + EDGE_MARGIN, 0), Vector2.DOWN, Vector2.LEFT),
	BOTTOM: EdgeSpawningInfo.new(Vector2(0, Global.SCREEN_HEIGHT + EDGE_MARGIN), Vector2.RIGHT, Vector2.UP),
}

func get_edge_spawning_info(edge: int):
	return _edge_spawning_infos.get(edge)