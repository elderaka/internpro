extends Button

@onready var pop_up = $PopUp

var item_id = "1"

func initialize_item(id):
	item_id = id
	
func _on_hover():
	pop_up.item_id = item_id
	pop_up.showing()
	pop_up.show()

func _on_exit():
	pop_up.hide()
