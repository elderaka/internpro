extends CharacterBody2D


const SPEED = 150.0
const ACCELERATION = 800.0
const FRICTION = 1000.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer = $Timer
@onready var sprite_2d = $Sprite2D


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var direction = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(direction, delta)
	apply_friction(direction, delta)
	update_sprite(direction)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		timer.start()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump():
	if is_on_floor() or timer.time_left:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		if Input.is_action_just_released("ui_accept") and velocity.y < JUMP_VELOCITY / 2:
			velocity.y = JUMP_VELOCITY / 2

func handle_acceleration(direction, delta):
	if direction != 0 :
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION * delta)

func apply_friction(direction, delta):
	if direction == 0:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)

func update_sprite(direction):
	if direction != 0:
		sprite_2d.self_modulate = Color.BLUE
	else:
		sprite_2d.self_modulate = Color.WHITE
	
	if not is_on_floor():
		sprite_2d.self_modulate = Color.RED
