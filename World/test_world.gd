extends Node2D

signal level_finished

@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var reward = $Reward
@onready var pauseMenu = $Pause
@onready var reward_selection = %"Reward Selection"

func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon
	pauseMenu.connect("exit_to_main", exit_to_menu)
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

func exit_to_menu():
	queue_free()

func picked_item():
	print("world picked item")
	emit_signal("level_finished")
	pause()
	queue_free()
