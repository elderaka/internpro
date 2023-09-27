extends Node2D
class_name  Player_Inventory

const SlotClass = preload("res://World/Player/Inventory/item_slot.gd")
@onready var inventory_slots = $items
@onready var weapon_slots = $weapon
@onready var lore_slots = $lore

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_inventory()
	initialize_weapon()
	initialize_lore()
	pass # Replace with function body.

func initialize_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0])

func initialize_weapon():
	var slots = weapon_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.weapon[i] != null:
			print(PlayerInventory.weapon[i])
			slots[i].initialize_item(PlayerInventory.weapon[i][0])

func initialize_lore():
	var slots = lore_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.lore.has(i):
			slots[i].initialize_item(PlayerInventory.lore[i][0])
	
func _process(delta):
	pass
