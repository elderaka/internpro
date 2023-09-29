extends "res://World/Levels/level.gd"

func _ready():
	reward_selection.connect("item_picked", picked_item)
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.connect("enemy_shoot", Callable(bullet_manager, "handle_bullet_spawn"))
	

func levelFinished():
	if not get_tree().paused:
		pause()
	reward.visible = true


func _on_finished_game_game_finished():
	emit_signal("game_finished")
