extends Node
class_name Sound_Queue

var _next : int = 0
var _audioStreamPlayers : Array[AudioStreamPlayer]

@export var Count : int = 1

func _ready():
	if get_child_count() == 0:
		print("No AudioStreamPlayer child found")
		return
	
	var child  = get_child(0)
	if child is AudioStreamPlayer:
		_audioStreamPlayers.append(child)
		for i in range(Count):
			var dupe : AudioStreamPlayer = child.duplicate() as AudioStreamPlayer
			add_child(dupe)
			_audioStreamPlayers.append(dupe)

func _get_configuration_warnings():
	if get_child_count() == 0:
		return "No children found. Expected one AudioStreamPlayer child."
	
	if get_child(0) != AudioStreamPlayer:
		return "Expected first child to be an AudioStramPlayer."

func PlaySound():
	if not _audioStreamPlayers[_next].playing:
		_audioStreamPlayers[_next].play()
		_next += 1
		_next %= _audioStreamPlayers.size()
