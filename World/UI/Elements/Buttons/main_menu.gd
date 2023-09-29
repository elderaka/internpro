extends Control

signal playGame()


func _on_play_pressed():
	emit_signal("playGame")
	ButtonSoundPool.PlayRandomSound(false)

func _on_exit_pressed():
	ButtonSoundPool.PlayRandomSound(false)
	get_tree().quit()
