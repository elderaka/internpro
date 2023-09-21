extends Node2D

@onready var map2 = $Map/Map
@onready var levels = $Level
@onready var map1 = $Map
@onready var mainMenu = load("res://World/UI/menu.tscn")
@onready var pauseFile = preload("res://World/UI/pause.tscn")

func _ready():
	map2.connect("picked_room", open_room)

func finished_a_level():
	levels.hide()
	map1.show()

func open_room(room, roomType):
	var level = room.instantiate()
	if roomType == "Fight":
		add_child(level)
	else:
		levels.add_child(level)
		levels.show()
	level.connect("level_finished", finished_a_level)
	map1.hide()

func _on_pause_exit_to_main():
	var menu = mainMenu.instantiate()
	add_child(menu)
	menu.connect("game_start", _on_menu_game_start)
	menu.connect("open_room", open_room)
	get_tree().get_nodes_in_group("level")[0].queue_free()


func _on_menu_game_start():
	var pause = pauseFile.instantiate()
	add_child(pause)
	pause.connect("exit_to_main", _on_pause_exit_to_main)
