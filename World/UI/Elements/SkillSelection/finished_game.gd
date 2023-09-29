extends MarginContainer

signal game_finished

func _on_button_pressed():
	emit_signal("game_finished")
