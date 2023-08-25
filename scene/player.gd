extends CharacterBody2D

@export var speed = 150
@export var gravity = 30
@export var jump_force = 300
var moving = "right"
var current_jump = 0
var max_jump = 2
var is_moving_left = false

func _physics_process(delta):
	if !is_on_floor():
		if velocity.y < 1000:
			velocity.y += gravity
	else:
		current_jump = 0
	
	if Input.is_action_just_pressed("up"):
		if current_jump < max_jump:
			velocity.y = -jump_force
			current_jump += 1
		
	
	var horizontal_direction = Input.get_axis("left","right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
		

	if Input.is_action_pressed("left") and !is_moving_left:
		is_moving_left = true
		moving = "left"
		scale.x = -scale.x
	elif Input.is_action_pressed("right") and is_moving_left:
		is_moving_left = false
		moving = "right"
		scale.x = -scale.x
	
	
	
	
	
