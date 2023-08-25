extends CharacterBody2D


@export var movement_data : PlayerMovementData
@export var Bullet : PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer = $Timer
@onready var sprite_2d = $Sprite2D
@onready var hold = $Hold
@onready var muzzle = $Marker2D/Muzzle
@onready var marker_2d = $Marker2D

var aiming = false


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var direction = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(direction, delta)
	apply_friction(direction, delta)
	apply_air_resistance(direction, delta)
	update_sprite(direction)
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		timer.start()
	
	marker_2d.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("Shoot"):
		if not aiming:
			spawnBullet()
			aiming = true
		else:
			aim()
	elif Input.is_action_just_released("Shoot"):
		shoot()
		aiming = false

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

func handle_jump():
	if is_on_floor() or timer.time_left:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = movement_data.jump_velocity
	if not is_on_floor():
		if Input.is_action_just_released("ui_accept") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2

func handle_acceleration(direction, delta):
	if direction != 0 :
		velocity.x = move_toward(velocity.x, movement_data.speed * direction, movement_data.acceleration * delta)

func apply_friction(direction, delta):
	if direction == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func apply_air_resistance(direction, delta):
	if direction == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)

func update_sprite(direction):
	if direction != 0:
		sprite_2d.self_modulate = Color.BLUE
	else:
		sprite_2d.self_modulate = Color.WHITE
	
	if not is_on_floor():
		sprite_2d.self_modulate = Color.DARK_GREEN

func spawnBullet():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = marker_2d.transform
	b.speed = 0

func aim():
	var b = $Projectile
	b.transform = marker_2d.transform

func shoot():
	var b = $Projectile
	remove_child(b)
	owner.add_child(b)
	b.speed = 300
	b.transform = marker_2d.transform
	b.global_position = muzzle.global_position
