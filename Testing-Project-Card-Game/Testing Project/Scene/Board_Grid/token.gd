extends Sprite2D

@onready var tile_map = $"../TileMap"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var mouse_tile = tile_map.local_to_map(get_global_mouse_position())
#	var local_pos = tile_map.map_to_local(mouse_tile)
#	var world_pos = tile_map.to_global(local_pos)
#	global_position = world_pos
#	print(world_pos)
#	print()
	pass
func _unhandled_input(event):
	if event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
		set_process(false)
		set_process_unhandled_input(false)
