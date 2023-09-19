extends Node
class_name Random_Picker

@export var itemList: Array[Random_Item] = []

func pick_random_item(itemArray : Array = itemList):
	randomize()
	var chosenValue = null
	if itemArray.size() > 0:
		#Step 1: Calculate the overall chance (basically the 100%)
		var overallChance = 0
		for item in itemArray:
			overallChance += item.pickedChance
		
		#Step 2: Generate ramdom number
		var randomNumber = randi() % overallChance
		
		#Step 3: Pick a random Item
		var offset: int = 0
		for item in itemArray:
			if item.canBePicked:
				if randomNumber < item.pickedChance + offset:
					chosenValue = item.value
					break
				else:
					offset += item.pickedChance
	
	#Step 4: Return value
	return chosenValue
