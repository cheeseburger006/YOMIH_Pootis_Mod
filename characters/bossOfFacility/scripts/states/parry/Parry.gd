extends GroundedParryState

func _frame_0():
	._frame_0()
	
	if not host.is_grounded():
		anim_name = "ParryAir"

