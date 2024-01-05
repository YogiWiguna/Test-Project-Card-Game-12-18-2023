extends Node2D

const MAX_HEALTH = 50
var health = MAX_HEALTH

@onready var health_bar = $HealthBar
@onready var label = $HealthBar/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	set_health_label()
	set_health_bar()
	health_bar.max_value = MAX_HEALTH
	Global.dice_rolled.connect(damage)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_health_bar():
	health_bar.value = health

func set_health_label():
	label.text = str(health)
#func _input(event):
#	if event.is_action_pressed("ui_accept"):
#		damage()


func damage(dice):
	health -= dice
	if health < 0:
		health = MAX_HEALTH
	set_health_bar()
	set_health_label()
