extends CharacterBody2D

@export var movement_data : EnemyMovementData
@export var stats : Enemy_Statistic
@onready var label = $Label
@onready var critNotif = $Label2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_chase = false
var player = null
var direction = Vector2.RIGHT

func _physics_process(delta):
	if player_chase:
		direction = position.direction_to(player.position)
		velocity.x = move_toward(velocity.x, direction.x * movement_data.speed, movement_data.acceleration * delta)
	
	if not player_chase:
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)
	
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta
	
	move_and_slide()

func _on_detection_area_body_entered(body):
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	player = null
	player_chase = false

func _on_hitbox_area_entered(area):
	pass
	#queue_free()

func take_damage(damage, isCrit):
	#stats.health -= damage
	
	if isCrit:
		critNotif.text = str("Critical hit!")
		label.text = str(damage)+ "!"
	else:
		label.text = str(damage)
		critNotif.text = str("")
