extends Area2D


@onready var tile_map = $"../TileMap"
@onready var sprite_2d = $Sprite2D

var astar_grid : AStarGrid2D
var current_id_path : Array[Vector2i]
var current_point_path: PackedVector2Array
var main_layer = 0
var main_atlas_id = 0
var is_pressed = false
var is_move = false
var target_position

## Change the tile color
var pos_clicked
var tile_above
var current_atlas_coords_above
var current_tile_above_alt
var tile_below
var current_atlas_coords_below
var current_tile_below_alt
var tile_left
var current_atlas_coords_left
var current_tile_left_alt
var tile_right
var current_atlas_coords_right
var current_tile_right_alt




func _ready():
	
	## Make a initial AstarGrid2D new for the first time
	astar_grid = AStarGrid2D.new()
	
	## Declare the region of the astar_grid that can be possible moving 
	## get_used_rect is for decalre the position of the tile_map (x,y) and also the size of the tile_map (x,y)
	## So the astar_grid can't go outside of the tile_map 
	astar_grid.region = tile_map.get_used_rect()
	
	## Make the cell size on the path is same like the tile map (64)
	astar_grid.cell_size = Vector2(64,64)
	
	## Make the diagonal mode is disable 
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	
	## Update the astar_grid region and cell
	astar_grid.update()
	
#	print(current_id_path)
#	print(tile_map.get_used_rect())
#	print(astar_grid.region)
	
	## Checking the tile data is walkable or not 
	## tile_map.get_used_rect().size.x is for checking the size of the tile map that applied on the 2D scene
	## Checking the size of tile map in x coordinat, total is 18 tiles ( it convert into 0-17 tiles)
	for x in tile_map.get_used_rect().size.x:
		## Checking the size of tile map in y coordinat
		## The total is 10 tiles (convert into 0-9)
		for y in tile_map.get_used_rect().size.y:
			## the x and y is only checking the size of the tiles on the 2d scene not the position
			
			## So to get the tile_position (all the exact positon and size of the tile map in 2d scene) 
			## We need to concatenate the x value with the value of position.x and do it same with the y coordinat 
			var tile_position = Vector2i(
				x + tile_map.get_used_rect().position.x,
				y + tile_map.get_used_rect().position.y
			)
#			print(x)
#			print(y)
#			print(tile_map.get_used_rect().position.x)
#			print(tile_map.get_used_rect().position.y)
#			print(x + tile_map.get_used_rect().position.x)
#			print(y + tile_map.get_used_rect().position.y)
#			print(tile_position)
			
			## Get the cell tile_data for make sure the player or token will move only in the tile_position area
			var tile_data = tile_map.get_cell_tile_data(0, tile_position)
			
			## Checking if the tile_data is null (there's no tile) or tile_data is not "walkable" (decalre on the custom data layer)
			if tile_data == null or tile_data.get_custom_data("walkable") == false:
				## If true the astar_grid will disabled the pathfinding going to the tile_data null or the tile data is not "walkable"
				astar_grid.set_point_solid(tile_position)
	


func _input(event):
	
	## If the left mouse is not pressed return to the next line code
	if event.is_action_pressed("left_mouse") == false:
		return "not preesed"

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		## Checking the click of the sprite or token , if it's clicked on the token set is_moving to true
		if sprite_2d.get_rect().has_point(to_local(event.position)):
			is_move = true
			pos_clicked = tile_map.local_to_map(global_position)
#			var current = tile_map.get_cell_atlas_coords()
			var current_atlas_coords = tile_map.get_cell_atlas_coords(main_layer,pos_clicked)
			var number_of_atlas_for_clicked = tile_map.tile_set.get_source(main_atlas_id).get_alternative_tiles_count(current_atlas_coords)

			## Tile Above the current tile is clicked
			tile_above = pos_clicked - Vector2i(0, 1) 
			current_atlas_coords_above = tile_map.get_cell_atlas_coords(main_layer,tile_above)
			current_tile_above_alt = tile_map.get_cell_alternative_tile(main_layer, tile_above)
			tile_map.set_cell(main_layer, tile_above, main_atlas_id, current_atlas_coords_above, (current_tile_above_alt + 1) % number_of_atlas_for_clicked)
		#	print("tile above", tile_above)
	
			### Tile Below the current tile is clicked
			tile_below = pos_clicked - Vector2i(0, -1)
			current_atlas_coords_below = tile_map.get_cell_atlas_coords(main_layer,tile_below)
			current_tile_below_alt = tile_map.get_cell_alternative_tile(main_layer, tile_below)
			tile_map.set_cell(main_layer, tile_below, main_atlas_id, current_atlas_coords_below, (current_tile_above_alt + 1) % number_of_atlas_for_clicked)
		#	print("tile below", tile_below)
			
			### Tile Left the current tile is clicked
			tile_left = pos_clicked - Vector2i(1, 0)
			current_atlas_coords_left = tile_map.get_cell_atlas_coords(main_layer,tile_left)
			current_tile_left_alt = tile_map.get_cell_alternative_tile(main_layer, tile_left)
			tile_map.set_cell(main_layer, tile_left, main_atlas_id, current_atlas_coords_left, (current_tile_above_alt + 1) % number_of_atlas_for_clicked)
		#	print("tile left", tile_left)
			
			### Tile Right the current tile is clicked
			tile_right = pos_clicked - Vector2i(-1, 0)
			current_atlas_coords_right = tile_map.get_cell_atlas_coords(main_layer,tile_right)
			current_tile_right_alt = tile_map.get_cell_alternative_tile(main_layer, tile_right)
			tile_map.set_cell(main_layer, tile_right, main_atlas_id, current_atlas_coords_right, (current_tile_above_alt + 1) % number_of_atlas_for_clicked)
		#	print("tile right", tile_right)
		## If not pressed the token set is_pressed to false , just make sure the physic process didnt run 
		else:
			is_pressed = false
#	var id_path
#	if is_moving:
#		id_path = astar_grid.get_id_path(
#			tile_map.local_to_map(target_position),
#			tile_map.local_to_map(get_global_mouse_position())
#		)
#	else :
#		id_path = astar_grid.get_id_path(
#			tile_map.local_to_map(global_position),
#			tile_map.local_to_map(get_global_mouse_position())
#		).slice(1)
	
#	print("token pressed")
#	is_pressed = true

	
	## Initial the id path ( from and the target path) for the astar grid 
	var id_path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(get_global_mouse_position())
	).slice(1) ## Slice the first position from first from_id
#	print(id_path.size())
#	print(tile_map.local_to_map((global_position)))
	
	## If id_path size equal to 1 , the value of is_moving is true because the token is already pressed
	## and set the is_pressed to true to make the _physics_process running
	if id_path.size() == 1:
		if is_move:
			## Set the is_pressd to true to make the physics_process running
			## Because when the token move to new tile the is_pressed is false, 
			## Why is_pressed is false because we decalre when other tile is pressed we set the is_pressed to false to make the _physics_process running not running 
			is_pressed = true
	## If id_path size not equal to 1 , clear id_path (Base on array)
	else :
		id_path.clear()
	
	
	## If the id_path is not empty so make the current_id_path to id_path
	## current_id_path is to use to get the movement condition
	if id_path.is_empty() == false:
		current_id_path = id_path
		
		## After checking the current_id_path is not empty we set the current_point_path to the target path
		## 
#		current_point_path = astar_grid.get_point_path(
#			tile_map.local_to_map(global_position),
#			tile_map.local_to_map(get_global_mouse_position())
#		)
		
		## Make sure the size of the current_point_path size is on the middle of the player or token
		## Usually the point is on the top left corner of the player or token 
#		for i in current_point_path.size():
##			print(current_point_path.size())
#			## current_point_path is the array to hold the Vector2
#			current_point_path[i] = current_point_path[i] + Vector2(32,32)


func _physics_process(delta):
	## Move 1 Tile
	## Checking if the current_id_path is empty , if true so return to the next line 
	if current_id_path.is_empty():
		return
	
#	if is_moving == false:
		## Return the current path id first array to target_position
		## map to local is for convert the Vector2i to Vector2
		## Positon we want to move to
	
	## Checking if is_pressed is true, make the token move and set the is_move to false 
	if is_pressed:
		is_move = false
		target_position = tile_map.map_to_local(current_id_path.front())
#		print(target_position)
		## Move token to the target and the speed
		global_position = global_position.move_toward(target_position, 2)
		
		#Above change tile
		tile_map.set_cell(0,tile_above, main_atlas_id,current_atlas_coords_above, 0 )
		#Below change tile
		tile_map.set_cell(0,tile_below, main_atlas_id,current_atlas_coords_below, 0 )
		#Left change tile
		tile_map.set_cell(0,tile_left, main_atlas_id,current_atlas_coords_left, 0 )
		#Right change tile
		tile_map.set_cell(0,tile_right, main_atlas_id,current_atlas_coords_right, 0 )
		
#	print(is_move, is_pressed)
	
	## if position of the token is equal to the target position 
	## The first array on the current_id_path is removes because the process will checking again and again from the array of 
	## current_path_id, removes it with pop_front
	if global_position == target_position:
		current_id_path.pop_front()
	
		#
#		if current_id_path.is_empty() == false:
#			target_position = tile_map.map_to_local(current_id_path.front())
#		else : 
#			is_moving = false
	
#	print (current_id_path)

