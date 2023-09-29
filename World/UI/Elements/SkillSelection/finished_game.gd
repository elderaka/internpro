extends MarginContainer

signal game_finished

func _on_button_pressed():
	ButtonSoundPool.PlayRandomSound(false)
	emit_signal("game_finished")
