class_name CardStateMachine
extends Node

@export var initial_state: CardState

var current_state: CardState
var states := {}

func init(card: CardUI) -> void:
	for child in get_children():
		if child is CardState:
#			print(child)
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card
#			print(child.card_ui)

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)
	
func _unhandled_input(event):
	if current_state:
		current_state._unhandled_input(event)

func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

func _on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

func _on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()


func _on_transition_requested(from: CardState, to : CardState.State) -> void:
	if from != current_state:
		return
	
	var new_state: CardState = states[to]
	if not new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
