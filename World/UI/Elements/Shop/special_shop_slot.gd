extends VBoxContainer

var item_id = 1
@onready var item = $"Special Slot"
@onready var price = $Label
@onready var stats = load("res://World/Player/DefaultPlayerStats.tres")
func initialize_item(id):
	item_id = id
	item.initialize_item(item_id)
	print(id)
	match JsonData.item_data[str(id)]["ItemCategory"]:
		"Tier 1": price.text = str(50)
		"Tier 2": price.text = str(200)
		"Tier 3": price.text = str(300)
		"Lore": price.text = str(750)
		"Weapon": price.text = str(500)
		_: price.text = str("SOLD")


func _on_item_slot_pressed():
	if price.text != "SOLD":
		stats.bytes -= int(price.text)
		price.text = "SOLD"
		PlayerInventory.add_item(JsonData.item_data[str(item_id)]["Name"])
		item.initialize_item(0)
	
	pass # Replace with function body.
