extends Control

signal exited

@onready var mainMenu = load("res://World/UI/menu.tscn")

func _input(event):
	if event.is_action_pressed("pause"):
		pause()

func pause():
	var newPausedState = not get_tree().paused
	get_tree().paused = newPausedState
	visible = newPausedState

func _on_resume_pressed():
	pause()


func _on_storage_pressed():
	pass # Replace with function body.


func _on_option_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	pause()
	var menu = mainMenu.instantiate()
	print(mainMenu)
	get_tree().get_nodes_in_group("game")[0].add_child(menu)
	emit_signal("exited")



