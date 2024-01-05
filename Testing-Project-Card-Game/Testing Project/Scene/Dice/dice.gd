extends Control

var rng = RandomNumberGenerator.new()
@onready var label = $Dice/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	rng.randomize()
	var dice = rng.randi_range(1,12)
	label.text = str(dice) 
	print(dice)
