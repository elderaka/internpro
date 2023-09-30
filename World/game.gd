extends Node2D

#@onready var map2 = $Map/Map
@onready var levels = $Level
@onready var mainMenu = load("res://World/UI/menu.tscn")
@onready var pauseFile = preload("res://World/UI/pause.tscn")
@onready var mapReload = preload("res://World/UI/Elements/Map/map.tscn")
@onready var map = %Map

@export var fightRooms : Array[Random_Item]

@export var reset = true

func finished_a_level():
	SceneTransition.fade_to_black()
	levels.hide()
	map.show()
	map.get_child(0).update()
	SceneTransition.fade_from_black()

func open_room(room, roomType):
	print("room opened", roomType)
	SceneTransition.fade_to_black()
	var level
	if roomType == "Fight":
		var levelPicker = Random_Picker.new()
		var picked = load(levelPicker.pick_random_item(fightRooms))
		level = picked.instantiate()
		add_child(level)
		if reset:
			get_tree().get_nodes_in_group("player")[0]._reset()
			reset = false
	elif roomType == "Boss":
		level = room.instantiate()
		add_child(level)
	else:
		level = room.instantiate()
		levels.add_child(level)
		levels.show()
	level.connect("level_finished", finished_a_level)
	level.connect("game_finished", _on_pause_exit_to_main)
	map.hide()
	SceneTransition.fade_from_black()
	

func _on_pause_exit_to_main():
	print("exit to main")
	SceneTransition.fade_to_black()
	var menu = mainMenu.instantiate()
	var pause = $Pause
	add_child(menu)
	menu.connect("game_start", _on_menu_game_start)
	menu.connect("open_room", open_room)
	if not get_tree().get_nodes_in_group("level").is_empty():
		get_tree().get_nodes_in_group("level")[0].queue_free()
	map.get_child(0).queue_free()
	pause.queue_free()
	if get_tree().paused:
		pause()
	SceneTransition.fade_from_black()
	reset = true
	get_tree().reload_current_scene()

func pause():
	var newPausedState = not get_tree().paused
	get_tree().paused = newPausedState

func _on_menu_game_start():
	print("game start")
	var pause = pauseFile.instantiate()
	add_child(pause)
	pause.connect("exit_to_main", _on_pause_exit_to_main)
	
	var newMap = mapReload.instantiate()
	newMap.connect("picked_room", open_room)
	map.add_child(newMap)
