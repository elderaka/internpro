extends CenterContainer

signal item_picked
signal level_finished

var getreward = true
var items = [1,2,3]
var order = 0
@onready var slot = $NinePatchRect/VBoxContainer/HBoxContainer

func _physics_process(delta):
	
	if visible and getreward:
		print("visible")
		getreward = false
		pick_item()
		print("WE HAVE " + str(items))
		initialize_item()
		print("And now " + str(items))
		order = 0
	
		
func initialize_item():
	var slots = slot.get_children()
	for i in range(slots.size()):
		slots[i].initialize_item(items[i])
			
func pick_item():
	print("Randomized")
	for i in range(2):
		roll()
		
func _on_item_select_pressed():
	print("picked")
	ButtonSoundPool.PlayRandomSound(true)
	emit_signal("item_picked")
	emit_signal("level_finished")
	queue_free()


func _on_button_pressed():
	print("picked")
	ButtonSoundPool.PlayRandomSound(false)
	emit_signal("item_picked")
	emit_signal("level_finished")
	queue_free()
	
func roll():
	#Intended probability: (From stage 1)
	#50% Tier 1
	#30% Tier 2
	#10% Tier 3
	#10% Weapon
	var dice = randf()
	if dice <= 0.5:
		getCommon()
	elif dice <= 0.8:
		getRare()
	elif dice <= 0.9:
		getEpic()
	else:
		if PlayerInventory.weapon.size() < 2:
			getWeapon()
		else:
			roll()

func getCommon():
	#Another dice roll, to pick which Item it will become
	items[order] = (randi_range(1,8))
	order += 1
	pass

func getRare():
	#Another dice roll, to pick which Item it will become
	items[order] = (randi_range(9,14))
	order += 1
	pass

func getEpic():
	#Another dice roll, to pick which Item it will become
	items[order] = (randi_range(15,19))
	order += 1
	pass

func getWeapon():
	#Another dice roll, to pick which Item it will become
	items[order] = (randi_range(23,27))
	order += 1
	pass
