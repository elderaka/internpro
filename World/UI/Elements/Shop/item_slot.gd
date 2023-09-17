extends Button

@onready var pop_up = $PopUp


func _on_hover():
	pop_up.show()

func _on_exit():
	pop_up.hide()
