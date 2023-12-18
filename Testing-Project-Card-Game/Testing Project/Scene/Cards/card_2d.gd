extends TextureButton

#@onready var CardDatabase = preload("res://Database/Cards_Database.gd")
#@onready var CardDatabaseTemp = CardDatabase.new()
#@onready var CardInfo = CardDatabaseTemp.DATA
var type : String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	callPlantImg(str(randi_range(0,4)))
#	callSeedImg(str(randi_range(0,4)))
#	callImgDatabase("seed")

func callSeedImg(p_type : String):
	type = p_type
	var textureCard = load("res://Assets/Cards/seed/seed_"+ type +".png")
	$Card.texture_normal = textureCard
	return get_node(".")

func callPlantImg(p_type : String):
	type = p_type
	var textureCard = load("res://Assets/Cards/plant/plant_"+ type +".png")
	$Card.texture_normal = textureCard
	return get_node(".")
	
func is_lower_value(card: Node) -> bool:
	var lower_type = int(type) < int(card.type)
	return lower_type

func matches_number(card: Node) -> bool:
	return type == card.type
	
#func callImgDatabase(card):
#	$Card.texture_normal = ResourceLoader.load(CardInfo[card].bean)
