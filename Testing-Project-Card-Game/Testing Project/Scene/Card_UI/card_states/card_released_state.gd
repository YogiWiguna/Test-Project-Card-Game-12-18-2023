extends CardState

var played : bool
@onready var hand = get_node("/root/Board/BoardUI/Hand")
@onready var card_base = $"../../Card_Base"
@onready var collision_shape_2d = $"../../DropPointDetector/CollisionShape2D"
@onready var image = $"../../Image"

#GameManager/Board_Canvas

func enter() -> void :
	card_ui.color.color = Color.DARK_VIOLET
	card_ui.state.text = "RELEASED"
	
	played = false
#	print(hand.get_children())
#	print(card_ui.targets)
	
	if card_ui.targets.is_empty():
		pass
	else:
		played = true
		print("play card for target(s) ", card_ui.targets)
		
		Global.initial_img = image.texture.resource_path
		var initial_img = Global.initial_img
		print(initial_img)
#		initial_img.substr(29,1)
		var img_get_str = initial_img.rsplit("/",true,2)
		print(img_get_str)
		print(card_ui.global_position)
		if img_get_str[1] == "seed":
			card_ui.image.texture = load("res://Assets/Token/seed/" + img_get_str[2])
		elif img_get_str[1] == "plant":
			card_ui.image.texture = load("res://Assets/Token/plant/" + img_get_str[2])
		card_ui.image.size = Vector2(43,43)
		card_ui.panel.visible = false
		card_ui.cost.visible = false
		
		card_ui.global_position = Global.local_pos
		print(card_ui.global_position)
#		card_ui.global_position = Vector2(928,352)
		collision_shape_2d.shape.size = Vector2(33, 41)
		collision_shape_2d.position = Vector2(25,25)
#		card_ui.stop_process()


func on_input(_event: InputEvent) -> void :
#	if card_ui
	if not played:
#		
		transition_requested.emit(self, CardState.State.BASE)
		
		

		card_ui.reparent(hand)
#		card_ui.stop_process()
		hand.move_child(card_ui,Global.card_index)
#		print(Global.card_index)
		
	return
	
