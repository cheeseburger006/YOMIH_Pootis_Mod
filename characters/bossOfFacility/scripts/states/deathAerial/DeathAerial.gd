extends CharacterState

func _tick():
	if current_tick > 3 and host.is_grounded():
		return land_cancel_state
