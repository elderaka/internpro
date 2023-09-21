extends CenterContainer

signal item_picked
signal level_finished

func _on_item_select_pressed():
	emit_signal("item_picked")
	emit_signal("level_finished")
	queue_free()


func _on_button_pressed():
	emit_signal("item_picked")
	
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
		getWeapon()

func getCommon():
	#Another dice roll, to pick which Item it will become
	pass

func getRare():
	#Another dice roll, to pick which Item it will become
	pass

func getEpic():
	#Another dice roll, to pick which Item it will become
	pass

func getWeapon():
	#Another dice roll, to pick which Item it will become
	pass
