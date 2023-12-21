extends Node2D

@onready var token = $"../Token"

func _process(delta):
	queue_redraw()

func _draw():
	if token.current_point_path.is_empty():
		return
	
	draw_polyline(token.current_point_path, Color.RED)
