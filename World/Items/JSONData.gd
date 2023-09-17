extends Node

var item_data : Dictionary


# Called when the node enters the scene tree for the first time.
func _ready():
	item_data = load_json_file("res://World/Items/ItemData.json")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_json_file(filepath : String):
	var dataFile = FileAccess.open(filepath, FileAccess.READ)
	var parsedResult = JSON.parse_string(dataFile.get_as_text())
	return parsedResult 
