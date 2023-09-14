extends Panel



@export var inventory = load("res://World/Player/PlayerInventory.gd")

var default_tex = preload("res://World/Player/Inventory/item_slot_default_background.png")
var empty_tex = preload("res://World/Player/Inventory/item_slot_empty_background.png")

var default_style : StyleBoxTexture = null
var empty_style : StyleBoxTexture = null

var itemClass = preload("res://sprite/Items/item.tscn")
var item = null
# Called when the node enters the scene tree for the first time.
func _ready():
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	refresh_style()
	
func initialize_item(item_name):
	if item == null:
		item = itemClass.instantiate()	
		add_child(item)
		item.set_item(item_name)
	else:
		item.set_item(item_name)
	refresh_style()
	
func refresh_style():
	if item == null:
		set("theme_override_styles/panel", empty_style)
	else:
		set("theme_override_styles/panel", default_style)
