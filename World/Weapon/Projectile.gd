extends Area2D

@export var weapon_stats : Weapon_Statistic
@export var speed = 300
@export var damage = 50
@export var multiplier = 1
@export var critChance = 0.0
@export var critDamage = 0.0
@export var pierce = 2
@export var force = 1
@export var isCrit = false
@export var animation = ""
@onready var sprite = $AnimatedSprite2D

func _ready():
	pass
	
func _physics_process(delta):
	sprite.play(animation)
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		var crit = critical()
		body.take_damage(crit.damage,crit.isCrit)
		if pierce > 0:
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
