extends Node2D


@export var item_id = 0
var names : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_item(item_name):
	$name.text = item_name
	
