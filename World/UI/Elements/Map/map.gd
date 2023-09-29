extends MarginContainer

signal picked_room(room, type)

@onready var bytes = %Bytes
@onready var v_box_container = $VBoxContainer
@onready var map_generator = $VBoxContainer/MapGenerator
@onready var generatorFile = preload("res://World/UI/Elements/Map/map_generator.tscn")

func _ready():
	map_generator.connect("picked_room", _on_map_generator_picked_room)
	map_generator.connect("refreshMap", _on_map_generator_refreshMap)

func update():
	bytes._on_in_game_ui_byte_changed(PlayerAutoload.bytes)

func _on_map_generator_picked_room(room, type):
	emit_signal("picked_room", room, type)

func _on_map_generator_refreshMap():
	map_generator.free()
	var newGenerator = generatorFile.instantiate()
	newGenerator.connect("picked_room", _on_map_generator_picked_room)
	newGenerator.connect("refreshMap", _on_map_generator_refreshMap)
	v_box_container.add_child(newGenerator)

