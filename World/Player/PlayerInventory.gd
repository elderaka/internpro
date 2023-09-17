extends Node

var max_slot = 5
var inventory = {
}

var max_weapon = 2
var weapon = ["dot", "lance"]

var max_lore = 3
var lore = {
}
func add_item(item_name):
	for i in range(max_slot):
		if inventory.has(i) == false:
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
		
