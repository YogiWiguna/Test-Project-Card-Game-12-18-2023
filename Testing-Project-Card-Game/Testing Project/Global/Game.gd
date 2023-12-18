extends Node


var card_index
var card_type = 0
var tile_map
var initial_img 
var local_pos : Vector2

#var world_pos : Vector2
######## EVENT ############
# Card-Related events
signal card_aim_started(card_ui: CardUI)
signal card_aim_ended(card_ui: CardUI)

signal deck_pressed


func pause():
	Engine.time_scale = 0

func resume():
	Engine.time_scale = 1

