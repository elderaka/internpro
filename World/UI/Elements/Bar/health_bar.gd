extends HBoxContainer

@onready var texture_progress_bar = $TextureProgressBar

func _on_in_game_ui_health_changed(health, max_health):
	texture_progress_bar.max_value = max_health
	texture_progress_bar.value = health
