extends NinePatchRect

var dot = load("res://World/UI/Elements/Item/Dot.tres")
var lance = load("res://World/UI/Elements/Item/Lance.tres")

@onready var texture_rect = $TextureRect

func _on_in_game_ui_weapon_changed(weapon):
	match weapon:
		"dot":
			texture_rect.texture = dot
		"lance":
			texture_rect.texture = lance
