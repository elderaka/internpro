class_name Enemy_Statistic
extends Resource

@export var type = "bit"
@export var health = 100
@export var damage = 50

func _ready():
	match type:
		"bit":
			health = 1000
			damage = 50
		"kilobit":
			health = 5000
			damage = 100
		"devmode":
			health = 100000
			damage = 0
