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
func add_item(item_name):
	#NOTE: THIS IS A VERY VERY VERY VERY BAD IMPLEMENTATION OF ADDING STATS
	#FIX THIS ASAP
	for i in range(max_slot):
		if inventory.has(i) == false:
			match item_name:
				"Dot Boost": stats.damage += 10
				"Crit Chance UP": stats.critChance += 0.1
				"Crit Damage UP": stats.critDamage += 0.1
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
			lore[i] = [item_name]
			return
		
