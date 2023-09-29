extends Node
class_name Finite_State_Machine

@export var state : State

func _ready():
	change_state(state)

func change_state(newState : State):
	if state is State:
		state._exit_state()
	newState._enter_state()
	state = newState
