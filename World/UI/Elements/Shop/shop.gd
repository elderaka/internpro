extends MarginContainer

signal level_finished

@onready var bytes = %Bytes

func _ready():
	bytes._on_in_game_ui_byte_changed(PlayerAutoload.bytes)

func _on_leave_pressed():
	ButtonSoundPool.PlayRandomSound()
	emit_signal("level_finished")
	queue_free()
