extends Button

var default_tex = preload("res://World/Player/Inventory/item_slot_default_background.png")
var empty_tex = preload("res://World/Player/Inventory/item_slot_empty_background.png")

var default_style : StyleBoxTexture = null
var empty_style : StyleBoxTexture = null

@onready var texture = $CenterContainer/VBoxContainer/TextureRect
@onready var names = $CenterContainer/VBoxContainer/Label
@onready var desc = $CenterContainer/VBoxContainer/RichTextLabel
var item = null
var picked = false
var type = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	default_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	default_style.texture = default_tex
	empty_style.texture = empty_tex
	refresh_style()
	
func _physics_process(delta):
	if button_pressed:
		picked = true
	
func _exit_tree():
	if picked:
		print("Picked " + names.text)
		match type:
			"Weapon":
				PlayerInventory.add_weapon(names.text)
			_:
				PlayerInventory.add_item(names.text)
		
	
func initialize_item(item_id):
	
	names.text = str(JsonData.item_data[str(item_id)]["Name"])
	desc.text = str(JsonData.item_data[str(item_id)]["Description"])
	type = str(JsonData.item_data[str(item_id)]["ItemCategory"])
	refresh_style()
	
func refresh_style():
	if item == null:
		set("theme_override_styles/panel", empty_style)
	else:
		set("theme_override_styles/panel", default_style)
