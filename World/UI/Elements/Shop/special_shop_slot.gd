extends VBoxContainer
signal not_enough
var item_id = 1
@onready var item = $"Special Slot"
@onready var price = $Label
@onready var stats = load("res://World/Player/DefaultPlayerStats.tres")
var prices = 0
func initialize_item(id):
	item_id = id
	item.initialize_item(item_id)
	print(id)
	match JsonData.item_data[str(id)]["ItemCategory"]:
		"Tier 1": prices = 50
		"Tier 2": prices = 200
		"Tier 3": prices = 300
		"Lore": prices = 750
		"Weapon": prices = 750
		_: prices = 0
	if prices != 0:
		price.text = str(prices)
	else:
		price.text = "SOLD"


func _on_item_slot_pressed():
	if price.text != "SOLD":
		if prices < stats.bytes:
			stats.bytes -= prices
			emit_signal("byte_change", stats.bytes)
			price.text = "SOLD"
			PlayerInventory.add_item(JsonData.item_data[str(item_id)]["Name"])
			item.initialize_item(0)
		else:
			not_enough.emit()
	
	pass # Replace with function body.
