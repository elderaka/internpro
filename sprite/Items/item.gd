extends Node2D


var item_id = 0

@onready var names = $name
# Called when the node enters the scene tree for the first time.
func _ready():
	item_id = randi_range(0,6)
	match item_id:
		0:
			names.text = "Rock"
		1:
			names.text = "Dot Boost"
		2:
			names.text = "RAM Upgrade"
		3:
			names.text = "Crit Chance UP"
		4:
			names.text = "Crit Damage UP"
		5:
			names.text = "Processor Boost"
		6:
			names.text = "Projectile Pierce"
