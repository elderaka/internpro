extends NinePatchRect

var dot = load("res://World/UI/Elements/Item/Dot.tres")
var lance = load("res://World/UI/Elements/Item/Lance.tres")
var datathrower = load("res://World/UI/Elements/Item/Dot_thrower.tres")
var bounce = load("res://World/UI/Elements/Item/Bounce.tres")
var laser = load("res://World/UI/Elements/Item/Laser.tres")
var spread = load("res://World/UI/Elements/Item/Dot.tres")

@onready var texture_rect = $TextureRect

#Ini kita ubah, soalnya pengen nyoba jadiin weapon, item, sama lore itu di satu json file aja

func _on_in_game_ui_weapon_changed(weapon):
	print(weapon)
	match weapon:
		"dot":
			texture_rect.texture = dot
		"lance":
			texture_rect.texture = lance
		"datathrower":
			texture_rect.texture = datathrower
		"bounce":
			texture_rect.texture = bounce
		"laser":
			texture_rect.texture = laser
		"spread":
			texture_rect.texture = spread
