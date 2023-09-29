extends Node
class_name Sound_Pool

var _sounds : Array[Sound_Queue]
var _random = RandomNumberGenerator.new()
var _lastIndex: int = -1

func _ready():
	for child in get_children():
		if child is Sound_Queue:
			_sounds.append(child)

func PlayRandomSound(ding : bool):
	var index = _random.randi_range(0, _sounds.size()-2)
	if ding:
		index = 3
	_lastIndex = index
	_sounds[index].PlaySound()
