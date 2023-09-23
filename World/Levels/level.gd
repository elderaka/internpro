extends Node2D

signal level_finished

@onready var reward_selection = %"Reward Selection"
@onready var reward = %Reward

var getReward = false
func _ready():
	reward_selection.connect("item_picked", picked_item)

func _physics_process(delta):
	if get_tree().get_nodes_in_group("enemy").is_empty():
		levelFinished()

func levelFinished():
	if not get_tree().paused:
		pause()
	reward.visible = true

func pause():
	var newPausedState = not get_tree().paused
	get_tree().paused = newPausedState

func picked_item():
	print("world picked item")
	emit_signal("level_finished")
	pause()
	queue_free()

