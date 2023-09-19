extends Node2D

@onready var map2 = $Map/Map
@onready var levels = $Level
@onready var map1 = $Map


func _ready():
	map2.connect("picked_room", open_room)

func finished_a_level():
	levels.hide()
	map1.show()

func open_room(room, roomType):
	var level = room.instantiate()
	if roomType == "Fight":
		add_child(level)
		level.connect("level_finished", finished_a_level)
	else:
		levels.add_child(level)
		levels.show()
	map1.hide()
	
