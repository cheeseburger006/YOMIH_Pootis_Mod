extends ThrowState

func _tick():
	if host.is_grounded():
		release_frame = current_tick+2
	
	if released and host.is_grounded():
		land_cancel = true

func _exit():
	release_frame = -1
	land_cancel = false
