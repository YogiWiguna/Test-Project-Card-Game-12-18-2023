class_name Card
extends Resource

enum Type {Seed, Plant}
enum Target {Area, Seed, Plant, Animal}
enum Target2 {Area, Seed, Plant, Animal}

@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target
@export var target2: Target2
@export var cost : int 


@export_group("Card Visuals")
@export var image : Array[Texture]
@export_multiline var tooltip_text : String


func is_area_targeted() -> bool:
	return target == Target.Area

func pick_random_card_image() -> Texture:
	return image[randi() % image.size()] as Texture
