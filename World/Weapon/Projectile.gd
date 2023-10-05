extends Area2D
@export var stat = load("res://World/Player/DefaultPlayerStats.tres")
@export var weapon_stats : Weapon_Statistic
@export var speed = 300
@export var damage = 50
@export var multiplier = 1
@export var critChance = 0.0
@export var critDamage = 0.0
@export var pierce = 1
@export var force = 1
@export var isCrit = false
@export var animation = ""
@onready var sprite = $AnimatedSprite2D
@export var lifespan = 0.5
var age = 1

func _ready():
	$Timer.wait_time += (stat.fireRate - 1) * 0.5
	pass
	
func _physics_process(delta):
	print($Timer.wait_time)
	if $Timer.is_stopped() and (animation == "thrower_0" or animation == "thrower_1"):
		queue_free()
	sprite.play(animation)
	position += transform.x * speed * delta


func _on_body_entered(body):
	var check = body.get_groups() == []
	if (not body.is_in_group(self.get_groups()[0]) and (not body.is_in_group("level")) and (not check)):
		var crit = critical()
		body.take_damage(crit.damage,crit.isCrit)
		if body.is_in_group("player"):
			body.knockback(self)
		if pierce > 0:
			pierce -= 1
		else:
			queue_free()
	elif body.is_in_group("level"):
		if weapon_stats.name == "bounce" and pierce > 0:
			speed = -speed
			pierce -= 1
		else:
			queue_free()
	else:
		queue_free()

func critical():
	randomize()
	var percent = randf()
	var isCrit = false
	#Algoritma untuk menentukan damage dari proyektil adalah sebagai berikut:
	#(stats.damage * weapon_multiplier) * critDamage
	var newDamage = damage * weapon_stats.damage_multiplier
	if percent <= critChance:
		isCrit = true
		newDamage *= critDamage
	#Return 2 values sekaligus, yaitu damage dan apakah damage tersebut critical atau tidak
	
	return {"damage": newDamage, "isCrit": isCrit}

func changeWeapon():
	pass
