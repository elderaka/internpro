extends CharacterBody2D

signal health_change(health, max_health)
signal byte_change(value)
signal weapon_change(weapon)

@export var movement_data : PlayerMovementData
@export var stats : Player_Statistic
@export var Bullet : PackedScene
@export var weapon_used : Weapon_Statistic

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var timer = $Timer
@onready var sprite_2d = $Sprite2D
@onready var hold = $Hold
@onready var muzzle = $Marker2D/Muzzle
@onready var marker_2d = $Marker2D

var aiming = false
var weapon_slot = PlayerInventory.weapon
var weapon_pos = 0
func _ready():
	weapon_used = load("res://World/Weapon/dot/dot_stats.tres")
	
func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var direction = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(direction, delta)
	apply_friction(direction, delta)
	apply_air_resistance(direction, delta)
	update_sprite(direction)
	update_health()
	update_bytes()
	update_weapon()
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
		if aiming:
			shoot()
			aiming = false
	
	if Input.is_action_just_pressed("add_item") and PlayerInventory.inventory.size() < PlayerInventory.max_slot:
		add_random_item()
	elif Input.is_action_just_pressed("add_item"):
		print("Full")
	if stats.health <= 0:
		restart_application()

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

func update_health():
	emit_signal("health_change", stats.health, stats.maxhealth)
	
func update_bytes():
	emit_signal("byte_change", stats.bytes)
	
func update_weapon():
	emit_signal("weapon_change", PlayerInventory.weapon[weapon_pos])
	if Input.is_action_just_pressed("change_weapon") and PlayerInventory.weapon[1] != null:
		if weapon_pos == 1:
			weapon_pos -= 1
		else:
			weapon_pos += 1
	
	
		
func spawnBullet():
	var b = Bullet.instantiate()
	add_child(b)
	b.animation = weapon_used.sprite
	b.weapon_stats = weapon_used
	b.transform = marker_2d.transform
	b.speed = 0

func aim():
	var b = $Projectile
	b.weapon_stats = weapon_used
	b.animation = weapon_used.sprite
	b.transform = marker_2d.transform

func shoot():
	var b = $Projectile
	remove_child(b)
	owner.add_child(b)
	b.speed = 300
	b.damage = stats.damage
	b.critChance = stats.critChance
	b.critDamage = stats.critDamage
	b.animation = weapon_used.sprite
	b.weapon_stats = weapon_used
	b.transform = marker_2d.transform
	b.global_position = muzzle.global_position

func take_damage(damage):
	stats.health -= damage
	emit_signal("health_change", stats.health, stats.maxhealth)
	
	
func restart_application():
	var executable_path = OS.get_executable_path()
	OS.execute(executable_path, [])  # Pass any command line arguments if needed
	get_tree().quit()  # Quit the current instance of the application
	
func add_random_item():
	var item_id = randi_range(0,3)
	match item_id:
		0:
			PlayerInventory.add_item("Dot Boost")
		1:
			PlayerInventory.add_item("Ram Upgrade")
		2:
			PlayerInventory.add_item("Crit Chance UP")
		3:
			PlayerInventory.add_item("Processor Boost")
