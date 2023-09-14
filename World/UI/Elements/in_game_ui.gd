extends Control

signal health_changed(health,max_health)
signal byte_changed(value)
signal weapon_changed(weapon)

func _ready():
	for node in get_tree().get_nodes_in_group("player"):
		if node.name == "Player":
			node.connect("byte_change", _on_player_byte_change)
			node.connect("health_change", _on_player_health_change)
			node.connect("weapon_change", _on_player_weapon_change)

func _on_player_health_change(health, max_health):
	emit_signal("health_changed", health, max_health)


func _on_player_byte_change(value):
	emit_signal("byte_changed", value)


func _on_player_weapon_change(weapon):
	emit_signal("weapon_changed", weapon)
