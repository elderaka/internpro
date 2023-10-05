extends MarginContainer

signal game_finished
@onready var stats = load("res://World/Player/DefaultPlayerStats.tres")
func _on_button_pressed():
	ButtonSoundPool.PlayRandomSound(false)
	var defstats = load("res://World/Player/DefaultPlayerStats.tres")
	stats = defstats
	hide()
	emit_signal("game_finished")
