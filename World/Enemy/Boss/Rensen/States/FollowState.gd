class_name Follow_State
extends State


@export var actor : Rensen
@export var animator : AnimationPlayer



func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)

func _exit_state() -> void:
	set_physics_process(false)



