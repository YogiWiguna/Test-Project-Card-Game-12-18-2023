extends Sprite2D

@onready var tile_map = $".."

var current_pos

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			print("token is pressed")
			var global_clicked = event.position
			current_pos = tile_map.local_to_map(global_clicked)
			print(current_pos)
			
		var tile_above = current_pos - Vector2i(0, 1) 
		if tile_above:
			print("tile above")
