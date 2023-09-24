extends Control

signal playGame()


func _on_play_pressed():
	emit_signal("playGame")
	ButtonSoundPool.PlayRandomSound()

func _on_exit_pressed():
	ButtonSoundPool.PlayRandomSound()
	get_tree().quit()
