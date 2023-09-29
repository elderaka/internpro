extends NinePatchRect

var item_id = "1"
@onready var names = $Label
@onready var sprite = $TextureRect
@onready var desc = $RichTextLabel
@onready var tag = $tier

func showing():
	item_id = str(item_id)
	names.text = JsonData.item_data[item_id]["Name"]
	desc.text = JsonData.item_data[item_id]["Description"]
	tag.text = JsonData.item_data[item_id]["ItemCategory"]
