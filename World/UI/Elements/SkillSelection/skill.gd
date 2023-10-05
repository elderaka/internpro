extends Button


@onready var skill_pop_up = %SkillPopUp
@onready var names = $MarginContainer/VBoxContainer/Name
@onready var desc = $MarginContainer/VBoxContainer/RichTextLabel
@onready var sprite = $MarginContainer/VBoxContainer/TextureRect
signal start()

func _on_focus_entered():
	skill_pop_up.show()


func _on_mouse_entered():
	skill_pop_up.show()


func _on_focus_exited():
	skill_pop_up.hide()


func _on_mouse_exited():
	skill_pop_up.hide()


func _on_pressed():
	match names.text:
		"Dot":
			PlayerInventory.weapon[0] = "dot"
		"Lance":
			PlayerInventory.weapon[0] = "lance"
		"Bounce":
			PlayerInventory.weapon[0] = "bounce"
		"Datathrower":
			PlayerInventory.weapon[0] = "datathrower"
		"Laser":
			PlayerInventory.weapon[0] = "laser"
	emit_signal("start")
