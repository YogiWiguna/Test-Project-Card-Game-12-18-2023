class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)
signal throw

const BASE_STYLEBOX := preload("res://Scene/Card_UI/card_base_stylebox.tres")
const DRAG_STYLEBOX := preload("res://Scene/Card_UI/card_dragging_stylebox.tres")
const HOVER_STYLEBOX := preload("res://Scene/Card_UI/card_hover_stylebox.tres")
@export var card: Card : set = _set_card

@onready var plant_card = preload("res://characters/plant/cards/plant_deck.tres")
@onready var seed_card = preload("res://characters/seed/cards/seed_deck.tres") 

@onready var panel = $Panel
@onready var image = $Image
@onready var cost = $Cost

@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var drop_point_detector: Area2D = $DropPointDetector
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var targets: Array[Node] = []
@onready var card_base = $Card_Base
@onready var collision_shape_2d = $DropPointDetector/CollisionShape2D
@onready var tile_map = $"../../../Area2D/TileMap"


var parent: Control
var tween : Tween
var area_token 
var type : String
var cardrandom = true
var change_to_token = false

func _ready() -> void:
#	print("ready ")
	card = plant_card
#	if cardrandom:
#		randomcard()
	
	card_state_machine.init(self)

func _process(delta):
	pass
#	if change_to_token:
#		check_coordinate()


#func cont_process():
#	set_process(true)
#
#func stop_process():
#	set_process(false)

#func check_coordinate():
#	var mouse_tile = tile_map.local_to_map(get_global_mouse_position())
#	var local_pos = tile_map.map_to_local(mouse_tile)
#	var world_pos = tile_map.to_global(local_pos)
#	global_position = world_pos
#	print(mouse_tile)


func _input(event: InputEvent) -> void:
#	if change_to_token:
#		check_coordinate()
	card_state_machine.on_input(event)

func animate_to_position(new_position: Vector2, duration: float) -> void:
	tween = create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "global_position", new_position,duration)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)


func _on_mouse_entered() -> void :
#	
	card_state_machine._on_mouse_entered()


func _on_mouse_exited() -> void:
	card_state_machine._on_mouse_exited()

func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	
	card = value
	cost.text = str(card.cost)
	image.texture = card.pick_random_card_image()

func _on_drop_point_detector_area_entered(area: Area2D) -> void :
	
	if not targets.has(area):
		targets.append(area)



func _on_drop_point_detector_area_exited(area):
#	print("dropexit")

	targets.erase(area)

func randomcard():
	Global.card_type += 1
#	print("text" + str(Global.card_type))
	callSeedImg(str(randi_range(0,4)))
	if Global.card_type > 3 :
		callPlantImg(str(randi_range(0,4)))
#	cardrandom = true


func callSeedImg(p_type : String):
#	print("seedImg")
	cardrandom = false
	type = p_type
	var textureCard = load("res://Assets/Cards/seed/seed_"+ type +".png")
	$Card_Base.texture = textureCard
	return get_node(".")

func callPlantImg(p_type : String):
#	print("plantImg")
	cardrandom = false
	type = p_type
	var textureCard = load("res://Assets/Cards/plant/plant_"+ type +".png")
	$Card_Base.texture = textureCard
	return get_node(".")

func is_lower_value(card: Node) -> bool:
	var lower_type = int(type) < int(card.type)
	return lower_type

func matches_number(card: Node) -> bool:
	return type == card.type

