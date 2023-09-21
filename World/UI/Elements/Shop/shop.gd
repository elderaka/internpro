extends MarginContainer

signal level_finished

func _on_leave_pressed():
	emit_signal("level_finished")
	queue_free()
