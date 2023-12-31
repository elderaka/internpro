extends CharacterBody2D

signal health_change(health, max_health)
signal byte_change(value)
signal weapon_change(weapon)
signal player_dies

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
@onready var firecd = $firerate
@onready var sound_queue = %SoundQueue
@onready var walk_sfx = $WalkSFX
@onready var hit_sound = %HitSound
@onready var weapon_sound = %WeaponSound

var aiming = false
var weapon_slot = PlayerInventory.weapon
var weapon_pos = 0
var weapon_sfx = 0
var direction

func _ready():
	weapon_used = load("res://World/Weapon/dot/dot_stats.tres")

func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	direction = Input.get_axis("ui_left", "ui_right")
	handle_acceleration(direction, delta)
	apply_friction(direction, delta)
	apply_air_resistance(direction, delta)
	update_sprite(direction)
	update_health()
	update_bytes()
	update_weapon()
	var was_on_floor = is_on_floor()
	if stats.ram <= 0:
		stats.ram = 0
	if velocity.x != 0 and is_on_floor():
		if !walk_sfx.playing:
			walk_sfx.play()
	elif walk_sfx.playing:
		walk_sfx.stop()
	
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		timer.start()
	
	marker_2d.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("Shoot"):
		if PlayerInventory.weapon[weapon_pos] != "datathrower" and PlayerInventory.weapon[weapon_pos] != "laser":
			if not aiming:
				spawnBullet()
				aiming = true
			else:
				aim()
		elif PlayerInventory.weapon[weapon_pos] == "datathrower" or PlayerInventory.weapon[weapon_pos] == "laser":
			var cooldown = false
			if cooldown == false:
				spawnBullet()
				firecd.start()
				shoot()
				cooldown = true
			elif firecd.time_left == 0:
				
				cooldown = false
	elif Input.is_action_just_released("Shoot"):
		if aiming:
			shoot()
			aiming = false
	
	elif Input.is_action_just_pressed("add_item"):
		print("Full")
	if stats.health <= 0:
		print("dead")
		emit_signal("player_dies")
		queue_free()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * movement_data.gravity_scale * delta

	
func handle_jump():
	
	if is_on_floor() or timer.time_left:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = movement_data.jump_velocity
			sound_queue.PlaySound()
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
	PlayerAutoload.health = stats.health
	PlayerAutoload.maxhealth = stats.maxhealth
	
func update_bytes():
	emit_signal("byte_change", stats.bytes)
	PlayerAutoload.bytes = stats.bytes
	
func update_weapon():
	emit_signal("weapon_change", PlayerInventory.weapon[weapon_pos])
	if Input.is_action_just_pressed("change_weapon") and PlayerInventory.weapon[1] != null:
		if weapon_pos == 1:
			weapon_pos -= 1
		else:
			weapon_pos += 1
	
	match PlayerInventory.weapon[weapon_pos]:
		"dot":
			weapon_used = load("res://World/Weapon/dot/dot_stats.tres")
			weapon_sfx = 0
		"lance":
			weapon_used = load("res://World/Weapon/lance/lance_stats.tres")
			weapon_sfx = 2
		"bounce":
			weapon_used = load("res://World/Weapon/bounce/bounce_stats.tres")
			weapon_sfx = 0
		"spread":
			weapon_used = load("res://World/Weapon/spread/spread_stats.tres")
			weapon_sfx = 3
		"datathrower":
			weapon_used = load("res://World/Weapon/datathrower/dt_stats.tres")
			weapon_sfx = 1
		"laser":
			weapon_used = load("res://World/Weapon/laser/laser_stats.tres")
			weapon_sfx = 1
			
		
func spawnBullet():
	var b = Bullet.instantiate()
	add_child(b)
	if weapon_used.sprite == "datathrower":
		var randsprite = randi_range(0,1)
		b.sprite.scale.x = 0.35
		b.sprite.scale.y = 0.35
		if randsprite == 0:
			b.animation = "thrower_0"
		else:
			b.animation = "thrower_1"
	else:
		b.animation = weapon_used.sprite
	b.weapon_stats = weapon_used
	b.transform = marker_2d.transform
	b.speed = 0
	print(b)

func aim():
	var b = $PlayerProjectile
	b.weapon_stats = weapon_used
	
	if weapon_used.sprite == "datathrower":
		b.sprite.scale.x = 0.35
		b.sprite.scale.y = 0.35
		var randsprite = randi_range(0,1)
		if randsprite == 0:
			b.animation = "thrower_0"
		else:
			b.animation = "thrower_1"
	else:
		b.animation = weapon_used.sprite
	b.transform = marker_2d.transform

func shoot():
	if stats.weapon == "datathrower" or stats.weapon == "laser":
		stats.ram -= 1
	else:
		stats.ram -= 10
	weapon_sound.PlayWeaponSound(weapon_sfx)
	var b = $PlayerProjectile
	remove_child(b)
	owner.add_child(b)
	b.speed = 300
	b.damage = stats.damage
	if stats.ram <= 0:
		b.damage -= stats.damage/2
	b.critChance = stats.critChance
	b.critDamage = stats.critDamage
	if weapon_used.sprite == "datathrower":
		var randsprite = randi_range(0,1)
		b.sprite.scale.x = 0.35
		b.sprite.scale.y = 0.35
		if randsprite == 0:
			b.animation = "thrower_0"
		else:
			b.animation = "thrower_1"
	else:
		b.animation = weapon_used.sprite
	b.weapon_stats = weapon_used
	b.transform = marker_2d.transform
	b.global_position = muzzle.global_position

func take_damage(damage, isCrit):
	hit_sound.PlaySound()
	stats.health -= damage
	print(ResourceLoader.load("res://World/Player/DefaultPlayerStats.tres").duplicate().bytes)
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

func knockback(body):
	var knockDir = self.global_position.direction_to(body.global_position)
	velocity.x = 300 * (knockDir.x * -1)
	velocity.y = 200 * (knockDir.x * -1)

func _reset():
	stats.health = 100
	stats.maxhealth = 100
	stats.ram = 100
	stats.maxram = 100
	stats.damage = 100
	stats.fireRate = 1.0
	stats.critChance = 0.12
	stats.critDamage = 0.2
	stats.pierce = 0
	stats.knockback = 1.0
	stats.lifesteal = 0.0
	stats.weapon = "dot"
	stats.bonusdata = 1.0
	stats.bytes = 100
	stats.weapon_slot = ["dot","lance"]
	stats.getKnockback = false
	stats.viewBar = false
	stats.isBerserker = false
	stats.lastStand = false
	stats.replenishHealth = false
	stats.replenishRAM = false
