extends "res://characters/states/Burst.gd"

const PootisUtils = preload("res://Pootis/mechanics/utils/RandomState.gd")

export var _c_Pootis_Vars = 0
export (String, MULTILINE) var burst_states

func _enter():
	var state = PootisUtils.get_random_state(burst_states.split("\n"))
	
	host.state_machine._change_state(state)
