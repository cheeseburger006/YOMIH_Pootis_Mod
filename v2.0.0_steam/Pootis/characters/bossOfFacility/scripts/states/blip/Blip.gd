extends CharacterState

func _tick():
	if current_tick > 3 and host.is_grounded():
		return land_cancel_state
	
	if current_tick + 1 == force_tick:
		apply_custom_grav = false
		apply_grav = true

func _exit():
	apply_custom_grav = true
	apply_grav = false
