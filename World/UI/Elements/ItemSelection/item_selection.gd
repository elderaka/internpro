extends CenterContainer

signal item_picked

func _on_item_select_pressed():
	emit_signal("item_picked")
