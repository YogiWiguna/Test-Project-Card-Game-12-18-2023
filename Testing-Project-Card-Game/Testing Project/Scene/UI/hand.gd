class_name Hand
extends HBoxContainer

var card_scene := preload("res://Scene/Card_UI/card_ui.tscn")
var card_played: Node
var hand : HBoxContainer = self

@onready var draw_pile_seed = $"../../DrawPileSeed"
@onready var draw_pile_plant = $"../../DrawPilePlant"
@onready var tile_map = $"../../Area2D/TileMap"


func _ready() -> void :
	Global.tile_map = tile_map
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.parent = self
		card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)


func _on_card_ui_reparent_requested(child: CardUI) -> void :
	child.reparent(self)


# SEED
func _on_draw_pile_seed_pressed() -> void:
	var new_card := instance_card_seed()
	hand.add_child(new_card)
	update_hand_spacing()

	#move the card into the correct ordered place
	var cards = hand.get_children()
	for i in len(cards):
		if new_card.is_lower_value(cards[i]):
#			hand.move_child(new_card, i)
			break
#	disabled_card()


func instance_card_seed() -> Node :
	var type := str(randi_range(0,4))
	var card = card_scene.instantiate().callSeedImg(type) 
#	card.connect("button_down",Callable(hand, "_on_Card_button_down").bind(card))
	return card 


## PLANT 
func _on_draw_pile_plant_pressed():
	var new_card := instance_card_plant()
	hand.add_child(new_card)
	update_hand_spacing()

	#move the card into the correct ordered place
	var cards = hand.get_children()
	for i in len(cards):
		if new_card.is_lower_value(cards[i]):
#			hand.move_child(new_card, i)
			break
#	disabled_card()

func instance_card_plant() -> Node :
	var type := str(randi_range(0,4))
	var card = card_scene.instantiate().callPlantImg(type) 
#	card.connect("button_down",Callable(hand, "_on_Card_button_down").bind(card))
	return card 

func update_hand_spacing() -> void:
	var cards = hand.get_children()
	if len(cards) == 0: 
		return

	var hand_size = hand.size.x / 1.5;
	var space_remaining: float = hand_size + cards[0].size.x * len(cards)
	var spacing: float = space_remaining / len(cards) -1
	hand.add_theme_constant_override("separation", min(spacing, -40))

func disabled_card():
	draw_pile_seed.disabled = true
	draw_pile_plant.disabled = true
