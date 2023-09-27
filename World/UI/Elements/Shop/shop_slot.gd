extends VBoxContainer

var item_id = 1
@onready var item = $"Item Slot"
@onready var price = $Label
	
	
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
