extends Control

signal exited



func _input(event):
	if event.is_action_pressed("pause"):
		pause()

func pause():
	var newPausedState = not get_tree().paused
	get_tree().paused = newPausedState
	visible = newPausedState

func _on_resume_pressed():
	ButtonSoundPool.PlayRandomSound(false)
	pause()


func _on_storage_pressed():
	ButtonSoundPool.PlayRandomSound(false)


func _on_option_pressed():
	ButtonSoundPool.PlayRandomSound(false)


func _on_exit_pressed():
	ButtonSoundPool.PlayRandomSound(false)
	pause()
	emit_signal("exited")



