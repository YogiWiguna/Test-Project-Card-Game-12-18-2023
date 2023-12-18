extends CardState

@onready var card_base = $"../../Card_Base"
@onready var drop_point_detector = $"../../DropPointDetector"
@onready var collision_shape_2d = $"../../DropPointDetector/CollisionShape2D"

func enter() -> void:
	card_ui.color.color = Color.ORANGE
	card_ui.state.text = "CLICKED"
	card_ui.drop_point_detector.monitoring = true
#	card_ui.cont_process()
	Global.card_index = card_ui.get_index()
#	Global.initial_img = card_base.texture.resource_path
#	var initial_img = Global.initial_img
##	initial_img.substr(29,1)
#	var img_get_str = initial_img.rsplit("/",true,2)
#	print(img_get_str)
##	Rsplit array 2 = "res://Assets/Cards", "seed", "seed_0.png"
#
#	if img_get_str[1] == "seed":
#		card_base.texture = load("res://Assets/Token/Seed/" + img_get_str[2])
#	elif img_get_str[1] == "plant":
#		card_base.texture = load("res://Assets/Token/Plant/" + img_get_str[2])
#
#	print(img_get_str)
#	card_base.size = Vector2(50,50)
##	card_base.position = Vector2(10,10)
##	drop_point_detector.scale = Vector2(0.9, 0.9)
#	collision_shape_2d.shape.size = Vector2(33, 41)
#	collision_shape_2d.position = Vector2(25,25)
#	card_ui.change_to_token = true

	

func on_input(event: InputEvent) -> void:
#	print("input")
	if event is InputEventMouseButton:
		transition_requested.emit(self, CardState.State.DRAGGING)
