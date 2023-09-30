extends "res://World/Levels/level.gd"

@onready var finished_game = $"Reward/Finished Game"
@onready var boss_start = $BossStart

func _ready():
	reward_selection.connect("item_picked", picked_item)
	for enemy in get_tree().get_nodes_in_group("enemy"):
		enemy.connect("enemy_shoot", Callable(bullet_manager, "handle_bullet_spawn"))
	boss_start.PlaySound()

func levelFinished():
	if not get_tree().paused:
		pause()
	sound_queue_victory.PlaySound()
	finished_game.visible = true


func _on_finished_game_game_finished():
	emit_signal("game_finished")
