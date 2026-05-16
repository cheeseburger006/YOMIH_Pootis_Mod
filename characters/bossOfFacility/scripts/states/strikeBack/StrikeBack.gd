extends CharacterState

export var _c_Pootis_Vars = 0
export (Array, int) var applied_forces_ticks
export (Array, Vector2) var applied_forces

func _tick():
	for i in len(applied_forces_ticks):
		if current_tick == applied_forces_ticks[i]:
			host.reset_momentum()
			host.apply_force_relative(str(applied_forces[i].x), str(applied_forces[i].y))
	
	if current_tick == no_collision_start_frame:
		host.start_invulnerability()
	
	if current_tick >= no_collision_end_frame:
		host.end_invulnerability()
