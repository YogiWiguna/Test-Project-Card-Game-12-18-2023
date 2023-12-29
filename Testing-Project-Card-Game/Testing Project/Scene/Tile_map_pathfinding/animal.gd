extends Area2D

@export var health : int

@onready var tile_map = $"../TileMap"
@onready var token = $"../Token"

@onready var animal = $animal

var astar_grid : AStarGrid2D
var is_moving : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = tile_map.get_used_rect()
	astar_grid.cell_size = Vector2(64,64)
	astar_grid.diagonal_mode = astar_grid.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	var region_size = astar_grid.region.size
	var region_position = astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			var tile_position = Vector2i(
				x + region_position.x,
				y + region_position.y
			)
			
			var tile_data = tile_map.get_cell_tile_data(0, tile_position)
			
			if tile_data == null or not tile_data.get_custom_data("walkable"):
				astar_grid.set_point_solid(tile_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	## Call funtion move here to make the animal move toward the token position automatically
	if is_moving:
		return
	
	move()

func move():
	## Checking for path from the animal positon to token position
	var path = astar_grid.get_id_path(
		tile_map.local_to_map(global_position),
		tile_map.local_to_map(token.global_position)
	)
	## Remove the first array of the path to make the animal moving to token place 
	path.pop_front()
	
#	print(path.size())
	if path.size() == 1:
		print("first tile")
		return
#
#	if path.size() == 3:
#		print("thrid tile")
#		return
###
#	if path.size() == 2:
##		print("second tile")
#		return
#	else : 
#		path.clear()
	
#	print(path.size())
	if path.is_empty():
#		print("cant'find path")
#		queue_free()
		return
	
	
	var original_position = Vector2(global_position)
	
	## Set global position of the enemy to first array path of the token
	## Change the tile_map from vector2i to Vector 2 with map to local
	## Because the tile_map is a vector2i
	global_position = tile_map.map_to_local(path[0])
	animal.global_position = original_position
	
	is_moving = true

func _physics_process(delta):
	if is_moving:
		## animal global position go toward the glboal_position of the token that has been set on the function move()
		animal.global_position = animal.global_position.move_toward(global_position, 1)
		
		## Checking if the animal global position is not the same as the node position than return the value 
		if animal.global_position != global_position:
			return
		
		## Set is_moving is false 
		is_moving = false


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
