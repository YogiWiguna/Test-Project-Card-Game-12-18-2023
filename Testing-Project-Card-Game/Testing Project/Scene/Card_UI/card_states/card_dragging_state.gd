extends CardState

const DRAG_MINIMUM_THRESHOULD := 0.05
@onready var drop_point_detector = $"../../DropPointDetector"

var minimum_drag_time_elapsed := false

func enter() -> void :
#	print("enter drag")
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
#		print("enter ui")
		card_ui.reparent(ui_layer)
		
		card_ui.color.color = Color.NAVY_BLUE
		card_ui.state.text = "DRAGGING"
		card_ui.panel.set("theme_override_styles/panel", card_ui.DRAG_STYLEBOX)

		minimum_drag_time_elapsed = false
		var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOULD, false)
		threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)


func on_input(event: InputEvent) -> void :
#	var area_targeted := card_ui.card.is_area_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion and card_ui.targets.size() > 0:
		
		transition_requested.emit(self, CardState.State.AIMING)
		return
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
#		print(card_ui.global_position)
	
	if cancel: 
		print("CANCEL")
		
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)

