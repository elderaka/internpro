extends CenterContainer

signal item_picked
signal level_finished

func _on_item_select_pressed():
	emit_signal("item_picked")
	emit_signal("level_finished")
	queue_free()


func _on_button_pressed():
	emit_signal("item_picked")
	emit_signal("level_finished")
	queue_free()
