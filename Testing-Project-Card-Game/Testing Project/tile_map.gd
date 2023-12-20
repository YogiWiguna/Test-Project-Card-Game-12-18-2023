extends TileMap

const main_layer = 0
const main_atlas_id = 0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = event.position
			var pos_clicked = local_to_map(to_local(global_clicked))
#			print(pos_clicked)
			var current_atlas_coords = get_cell_atlas_coords(main_layer,pos_clicked)
#			print(current_atlas_coords)
			var current_tile_alt = get_cell_alternative_tile(main_layer, pos_clicked)
#			print(current_tile_alt)
			var number_of_atlas_for_clicked = tile_set.get_source(main_atlas_id).get_alternative_tiles_count(current_atlas_coords)
#			print(number_of_atlas_for_clicked)
			set_cell(main_layer, pos_clicked, main_atlas_id, current_atlas_coords, (current_tile_alt + 1) % number_of_atlas_for_clicked)
			
			## If the mouse button left is being pressed the tile on 
			### the above, below , left and right current tile is show (red)
			if event.pressed:
				## Tile Above the current tile is clicked
				var tile_above = pos_clicked - Vector2i(0, 1) 
				var current_atlas_coords_above = get_cell_atlas_coords(main_layer,tile_above)
				var current_tile_above_alt = get_cell_alternative_tile(main_layer, tile_above)
				set_cell(main_layer, tile_above, main_atlas_id, current_atlas_coords_above, (current_tile_above_alt + 1) % number_of_atlas_for_clicked)
#				print("tile above", tile_above)
				
				### Tile Below the current tile is clicked
				var tile_below = pos_clicked - Vector2i(0, -1)
				var current_atlas_coords_below = get_cell_atlas_coords(main_layer,tile_below)
				var current_tile_below_alt = get_cell_alternative_tile(main_layer, tile_below)
				set_cell(main_layer, tile_below, main_atlas_id, current_atlas_coords_below, (current_tile_below_alt + 1) % number_of_atlas_for_clicked)
#				print("tile below", tile_below)
				
				### Tile LEft the curren tile is clicked
				var tile_left = pos_clicked - Vector2i(1, 0)
				var current_atlas_coords_left = get_cell_atlas_coords(main_layer,tile_left)
				var current_tile_left_alt = get_cell_alternative_tile(main_layer, tile_left)
				set_cell(main_layer, tile_left, main_atlas_id, current_atlas_coords_left, (current_tile_left_alt + 1) % number_of_atlas_for_clicked)
#				print("tile left", tile_left)
				
				### Tile LEft the curren tile is clicked
				var tile_right = pos_clicked - Vector2i(-1, 0)
				var current_atlas_coords_right = get_cell_atlas_coords(main_layer,tile_right)
				var current_tile_right_alt = get_cell_alternative_tile(main_layer, tile_right)
				set_cell(main_layer, tile_right, main_atlas_id, current_atlas_coords_right, (current_tile_right_alt + 1) % number_of_atlas_for_clicked)
#				print("tile right", tile_right)
		
