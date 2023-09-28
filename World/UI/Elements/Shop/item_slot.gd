extends Button

@onready var pop_up = $PopUp
@onready var price = $Label
var stats = load("res://World/Player/DefaultPlayerStats.tres")
var item_id = "1"

func initialize_item(id):
	item_id = id
	
func _on_hover():
	if item_id != 0:
		
		pop_up.item_id = item_id
		pop_up.showing()
		pop_up.show()
		if item_id == 0:
			pop_up.hide()
	else:
		pop_up.hide
		

func _on_exit():
	pop_up.hide()
