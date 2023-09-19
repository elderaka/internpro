extends CanvasLayer

signal exit_to_main


func _on_pause_exited():
	emit_signal("exit_to_main")
