extends CardState

@onready var collision_shape_2d = $"../../DropPointDetector/CollisionShape2D"
@onready var card_base = $"../../Card_Base"
@onready var hand = get_node("/root/Board/BoardUI/Hand")



func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	
#	print("cardBase")
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color.WEB_GREEN
	card_ui.state.text = "BASE"
	card_ui.pivot_offset = Vector2.ZERO
	card_ui.z_index = 0
	

func on_gui_input(event: InputEvent) -> void :
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICK)

func on_mouse_entered()-> void :
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLEBOX)
	card_ui.position.y = 0
	card_ui.scale = Vector2(1.3 , 1.3)
	card_ui.position.x = card_ui.position.x - 50
	card_ui.z_index = 1
#	print("card bigger")
	pass


func on_mouse_exited()-> void :
#	print("base out")
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.position.x = card_ui.position.x + 50
	card_ui.position.y = 104
	card_ui.scale = Vector2(1, 1 )
	card_ui.z_index = 0
	pass

	
