extends CanvasLayer

signal open_room(room, roomType)
signal game_start

@export var main_menu: PackedScene
@export var skill_selection: PackedScene
@export var level_one: PackedScene

@onready var margin_container = $MarginContainer
@onready var game = $".."

var curr_menu

func _ready():
	checkMenu()

func checkMenu():
	curr_menu = margin_container.get_child(0)
	if curr_menu.name == "MainMenu":
		curr_menu.connect("playGame", _on_main_menu_play_game)
	elif curr_menu.name == "Skill Selection":
		curr_menu.connect("back", _on_in_game_ui_back)
		curr_menu.connect("play", _on_in_game_ui_play)

func _on_main_menu_play_game():
	await SceneTransition.fade_to_black()
	var skillMenu = skill_selection.instantiate()
	margin_container.remove_child(curr_menu)
	margin_container.add_child(skillMenu)
	checkMenu()
	SceneTransition.fade_from_black()

func _on_in_game_ui_back():
	await SceneTransition.fade_to_black()
	var mainMenu = main_menu.instantiate()
	margin_container.remove_child(curr_menu)
	margin_container.add_child(mainMenu)
	checkMenu()
	SceneTransition.fade_from_black()

func _on_in_game_ui_play():
	if level_one is PackedScene:
		emit_signal("open_room", level_one, "Fight")
		emit_signal("game_start")
		queue_free()
