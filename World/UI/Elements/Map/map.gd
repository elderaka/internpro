extends MarginContainer

signal picked_room(room, type)

@onready var bytes = %Bytes

func update():
	bytes._on_in_game_ui_byte_changed(PlayerAutoload.bytes)

func _on_map_generator_picked_room(room, type):
	emit_signal("picked_room", room, type)
