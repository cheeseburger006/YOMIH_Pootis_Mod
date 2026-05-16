extends Getup

const PootisUtils = preload("res://Pootis/mechanics/utils/RandomState.gd")

func _tick():
	if host.hp <= 0:
		return PootisUtils.get_random_state(host.death_states.split("\n"))
