extends CenterContainer

signal back()
signal play()

@onready var h_box_container = $VBoxContainer/ScrollContainer/HBoxContainer


func _ready():
	for node in h_box_container.get_children():
		node.connect("start", _on_skill_start)

func _on_button_pressed():
	emit_signal("back")

func _on_skill_start():
	emit_signal("play")
