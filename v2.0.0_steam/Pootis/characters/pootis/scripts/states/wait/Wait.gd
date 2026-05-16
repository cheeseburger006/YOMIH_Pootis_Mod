extends "res://characters/states/Idle.gd"

const PootisUtils = preload("res://Pootis/mechanics/utils/RandomState.gd")

func _tick():
	host.apply_fric()
	host.apply_forces()

	if auto_fall:
		if not host.is_grounded():
			return "Fall"
	if host.hp <= 0:
		return PootisUtils.get_random_state(host.death_states.split("\n"))
