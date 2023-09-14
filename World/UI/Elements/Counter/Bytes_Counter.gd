extends NinePatchRect

@onready var label = $Label

func _on_in_game_ui_byte_changed(value):
	label.text = str(value)
