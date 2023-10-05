extends Node2D

signal level_finished
signal game_finished

@onready var reward_selection = %"Reward Selection"
@onready var reward = %Reward
@onready var bullet_manager = %BulletManager
@onready var dead = $"Dead/Finished Game"
@onready var sound_queue_victory = $Sound_QueueVictory
@onready var sound_queue_defeat = $Sound_QueueDefeat

var getReward = false
var finished = false

func _ready():
	reward_selection.connect("item_picked", picked_item)
	#for enemy in get_tree().get_nodes_in_group("enemy"):
	#	enemy.connect("enemy_shoot", Callable(bullet_manager, "handle_bullet_spawn"))
	#for player in get_tree().get_nodes_in_group("player"):
	#	player.connect("player_shoot", Callable(bullet_manager, "handle_bullet_spawn"))

func _physics_process(delta):
	if get_tree().get_nodes_in_group("enemy").is_empty() and !finished:
		finished = true
		levelFinished()

func levelFinished():
	if not get_tree().paused:
		pause()
	print("real")
	sound_queue_victory.PlaySound()
	reward_selection.visible = true
	reward_selection.getreward =  true
	print("Finished")

func player_died():
	if not get_tree().paused:
		pause()
	sound_queue_defeat.PlaySound()
	dead.visible = true
	

func pause():
	var newPausedState = not get_tree().paused
	get_tree().paused = newPausedState

func picked_item():
	print("world picked item")
	emit_signal("level_finished")
	pause()
	queue_free()

func _on_finished_game_game_finished():
	print("end")
	emit_signal("game_finished")
