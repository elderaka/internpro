extends NinePatchRect

var dot = load("res://World/UI/Elements/Item/Dot.tres")
var lance = load("res://World/UI/Elements/Item/Lance.tres")

@onready var texture_rect = $TextureRect

#Ini kita ubah, soalnya pengen nyoba jadiin weapon, item, sama lore itu di satu json file aja

func _on_in_game_ui_weapon_changed(weapon):
	match weapon:
		"dot":
			texture_rect.texture = dot
		"lance":
			texture_rect.texture = lance
