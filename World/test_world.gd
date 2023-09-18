extends Node2D


@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var reward = $Reward

var getReward = false
func _ready():
	polygon_2d.polygon = collision_polygon_2d.polygon

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
