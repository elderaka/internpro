extends MarginContainer

signal picked_room(room, type)


func _on_map_generator_picked_room(room, type):
	emit_signal("picked_room", room, type)
