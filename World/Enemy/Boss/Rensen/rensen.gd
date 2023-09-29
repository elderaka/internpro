extends CharacterBody2D
class_name Rensen

signal enemy_shoot(bullet, pos, direction)
signal healt_change(value, max_health)

@export var renStats : Enemy_Statistic
@export var renMovement : EnemyMovementData
@export var bullet : PackedScene
@onready var spread_shot = $SpreadShot
@onready var circle_shot_timer = $CircleShotTimer
@onready var animation_tree = $AnimationTree
@onready var collision_shape_2d = $CollisionShape2D

@export var health = 100
@export var max_health = health
@export var fight = false

var points : Array
var curPoint

var player = null
var firstDeath = false

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	max_health = renStats.health
	health = renStats.health
	circle_shot_timer.start()

func set_state_condition(name: String, value: bool):
	animation_tree.set("parameters/conditions/" + name, value)

# Move State
func move_to_closest_point():
	var point = get_new_point()
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", point.global_position, 1)

func get_new_point() -> Object:
	randomize()
	var newPoints : Array
	var closestPos : Object
	var closest
	
	for point in points:
		if point != curPoint:
			newPoints.append(point)
	
	
	closestPos = newPoints[0]
	closest = closestPos.global_position.distance_to(player.global_position)
	
	for point in newPoints:
		var distance = point.global_position.distance_to(player.global_position)
		
		if distance < closest:
			closest = distance
			closestPos = point
	
	var randomNum = randf_range(0.0, 1.0)
	if randomNum > 0.7:
		#var curIndex = newPoints.find(closestPos)
		newPoints.erase(closestPos)
		var randMove = randi() % newPoints.size()
		closestPos = newPoints[randMove]
	
	curPoint = closestPos
	return closestPos

func get_points(arrPoints : Array):
	points = arrPoints

#Spreadshot State
func SpreadShoot():
	spread_shot.look_at(player.global_position)
	for mark in spread_shot.get_children():
		var newBullet = bullet.instantiate()
		emit_signal("enemy_shoot", newBullet, mark.global_position, spread_shot.rotation)

#Circle shot state
func circleShot():
	var newBullet = bullet.instantiate()
	var mark = spread_shot.get_child(2)
	emit_signal("enemy_shoot", newBullet, mark.global_position, spread_shot.rotation)

func _on_circle_shot_timer_timeout():
	print("set")
	set_state_condition("circleAttack", true)

func move_to_top():
	var point = points[0]
	var tween = create_tween()
	tween.tween_property(self, "global_position", point.global_position, 0.1)
	curPoint = point

func take_damage(damage, isCrit):
	health -= damage
	emit_signal("healt_change", health, max_health)
	
	if ((not firstDeath) and health <=0):
		print("Test")
		set_state_condition("FirstDeath", true)
		collision_shape_2d.disabled
		firstDeath = true
	elif firstDeath and health <= 0 and fight:
		print("lastDeath")
		set_state_condition("FinalDeath", true)

func update_health():
	health += (renStats.health /20)
	if health > max_health:
		health = max_health
	emit_signal("healt_change", health, max_health)



func _on_animation_tree_animation_started(anim_name):
	print(anim_name)
