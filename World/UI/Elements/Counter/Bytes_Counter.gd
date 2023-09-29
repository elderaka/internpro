extends NinePatchRect

@onready var label = $Label
@onready var stats = load("res://World/Player/DefaultPlayerStats.tres")
func _ready():
	_on_in_game_ui_byte_changed(PlayerAutoload.bytes)

func _physics_process(delta):
	label.text = str(stats.bytes)
	
func _on_in_game_ui_byte_changed(value):
	label.text = str(value)
