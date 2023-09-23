extends Node2D

@onready var map2 = $Map/Map
@onready var levels = $Level
@onready var mainMenu = load("res://World/UI/menu.tscn")
@onready var pauseFile = preload("res://World/UI/pause.tscn")
@onready var mapReload = preload("res://World/UI/Elements/Map/map.tscn")
@onready var map = %Map

@export var fightRooms : Array[Random_Item]

func _ready():
	map2.connect("picked_room", open_room)

func finished_a_level():
	levels.hide()
	map.show()
	map2.update()

func open_room(room, roomType):
	var level
	if roomType == "Fight":
		var levelPicker = Random_Picker.new()
		var picked = load(levelPicker.pick_random_item(fightRooms))
		level = picked.instantiate()
		add_child(level)
	else:
		level = room.instantiate()
		levels.add_child(level)
		levels.show()
	level.connect("level_finished", finished_a_level)
	map.hide()

func _on_pause_exit_to_main():
	var menu = mainMenu.instantiate()
	add_child(menu)
	menu.connect("game_start", _on_menu_game_start)
	menu.connect("open_room", open_room)
	if not get_tree().get_nodes_in_group("level").is_empty():
		get_tree().get_nodes_in_group("level")[0].queue_free()
	map.get_child(0).queue_free()
	var newMap = mapReload.instantiate()
	add_child(newMap)
	


func _on_menu_game_start():
	var pause = pauseFile.instantiate()
	add_child(pause)
	pause.connect("exit_to_main", _on_pause_exit_to_main)
