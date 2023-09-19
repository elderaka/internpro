extends CenterContainer

signal item_picked

func _on_item_select_pressed():
	print("pressed")
	emit_signal("item_picked")


func _on_button_pressed():
	print("pressed")
	emit_signal("item_picked")
