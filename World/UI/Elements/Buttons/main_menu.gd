extends Control

signal playGame()

func _on_play_pressed():
	emit_signal("playGame")

func _on_exit_pressed():
	get_tree().quit()
