extends Node2D

const ARC_POINTS := 8

@onready var area_2d = $Area2D
@onready var card_arc = $CanvasLayer/CardArc


var current_card: CardUI
var targeting := false

func _ready()-> void :
	Global.card_aim_started.connect(_on_card_aim_started)
	Global.card_aim_ended.connect(_on_card_aim_ended)


func _process(delta: float) -> void:
	
	if not targeting:
		return
	
	area_2d.position = get_local_mouse_position()
	card_arc.points = _get_points()
	
	
	var area_2d_pos = get_global_mouse_position()
	var mouse_tile = Global.tile_map.local_to_map(area_2d_pos)
	Global.local_pos = Global.tile_map.map_to_local(mouse_tile)
#	Global.world_pos = Global.tile_map.to_global(Global.local_pos)
	global_position = mouse_tile
#	print(mouse_tile)
#	print(Global.local_pos)
#	print(Global.world_pos)
#	print(area_2d_pos)

func _get_points() -> Array :
	var points := []
	var start := current_card.global_position
	start.x += (current_card.size.x / 2)
	var target := get_local_mouse_position()
	var distance := (target - start)
	
	for i in range(ARC_POINTS):
		var t := (1.0 / ARC_POINTS) * i
		var x := start.x + (distance.x / ARC_POINTS) * i
		var y := start.y + ease_out_cubic(t) * distance.y
		points.append(Vector2(x,y))
		
	points.append(target)
	
	return points
	
func ease_out_cubic(number : float) -> float:
	return 1.0 - pow(1.0 - number, 3.0)
	

func _on_card_aim_started(card:CardUI) -> void:
	if not card.card.is_area_targeted():
		return
	
	targeting = true
	area_2d.monitorable = true
	area_2d.monitoring = true
	current_card = card
	

func _on_card_aim_ended(_card: CardUI) -> void :
	targeting = false
	card_arc.clear_points()
	area_2d.position = Vector2.ZERO
	area_2d.monitorable = false
	area_2d.monitoring = false
	current_card = null
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	if not current_card.targets.has(area):
		current_card.targets.append(area)
		

func _on_area_2d_area_exited(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	current_card.targets.erase(area)
