extends Panel
var stats = load("res://World/Player/DefaultPlayerStats.tres")
func _ready():
	pass

func _physics_process(delta):
	stats = load("res://World/Player/DefaultPlayerStats.tres")
	$damage.text = "Damage: " + str(stats.damage)
	$critChance.text = "Crit Chance: " + str(stats.critChance)
	$critDamage.text = "Crit Damage: " + str(stats.critDamage)
