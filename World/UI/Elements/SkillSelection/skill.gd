extends Button


@onready var skill_pop_up = %SkillPopUp

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
	emit_signal("start")
