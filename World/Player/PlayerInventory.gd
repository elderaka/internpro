extends Node

var max_slot = 12
var inventory = {
}

var max_weapon = 2
var weapon = ["dot", "lance"]

var max_lore = 3
var lore = {
}
var stats = load("res://World/Player/DefaultPlayerStats.tres")
var movestats = load("res://World/Player/DefaultPlayerMovement.tres")
func add_item(item_name):
	#NOTE: THIS IS A VERY VERY VERY VERY BAD IMPLEMENTATION OF ADDING STATS
	#FIX THIS ASAP
	for i in range(max_slot):
		if inventory.has(i) == false:
			match item_name:
				"Dot Boost":
					stats.damage *= 1.1
				"RAM Upgrade":
					stats.ram += 25
				"Crit Chance UP":
					stats.critChance += 0.10
				"Crit Damage UP":
					stats.critDamage += 0.20
				"Processor Boost":
					stats.firerate *= 1.1
				"Projectile Pierce":
					stats.pierce += 1
				"Knock-Down":
					stats.knockback += 1
				"Vampirism":
					stats.lifesteal += 0.1
				"Data GET+":
					stats.bonusdata += 0.5
				"Speedster":
					stats.firerate *= 1.25
					movestats.speed *= 1.5
				"Overclock":
					stats.maxhealth *= 0.9
					stats.health = stats.maxhealth
					stats.ram = stats.maxram
				"Cannon-Ball":
					stats.knockback += 2
					stats.firerate *= 0.9
					stats.getKnockback = true
				"Sniper":
					stats.firerate *= 0.75
					stats.critChance += 0.25
					stats.critDamage += 0.5
				"Eagle Eyes":
					stats.viewBar = true
					stats.critChance += 0.2
					stats.knockback += 1
				"Mayhem":
					stats.fireRate *= 2.5
					stats.critRate = 0
					stats.critChance = 0
				"Berserker":
					stats.isBerserker = true
				"Last Stand":
					stats.lastStand = true
					stats.damage *= 2
				"Turtle":
					movestats.speed *= 0.5
					stats.hp *= 2
				"Precision Shooter":
					stats.critChance += 1
					stats.firerate *= 0.3
					if stats.critChance > 1:
						stats.critDamage += stats.critChance - 1
						stats.critChance = 1
			inventory[i] = [item_name]
			return

func add_weapon(item_name):
	for i in range(max_weapon):
		if weapon.has(i) == false:
			weapon[i] = [item_name]
			return
			
func add_lore(item_name):
	for i in range(max_lore):
		if lore.has(i) == false:
			match item_name:
				"Charlotte’s Vinyl":
					stats.maxHealth *= 1.25
					stats.health = stats.maxHealth
					stats.replenishHealth = true
				"Charlotte’s Dress":
					stats.maxRam *= 1.5
					stats.ram = stats.maxRam
					stats.replenishRAM = true
				"Charlotte’s Hologram":
					max_slot += 3
			lore[i] = [item_name]
			return
		
