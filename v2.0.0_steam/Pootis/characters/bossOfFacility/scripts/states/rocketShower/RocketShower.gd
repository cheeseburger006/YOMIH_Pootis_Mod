extends CharacterState

export var _c_Pootis_Vars = 0
export (Array, PackedScene) var projectiles
export (Array, Vector2) var projectile_pos
export (Array, Vector2) var projectile_dirs
export (Array, int) var projectile_spawn_ticks

func _tick():
	var cameras = get_tree().get_nodes_in_group("Camera")
	
	for i in range(cameras.size()):
		cameras[i].focused_object = null
		cameras[i].global_position = cameras[i].last_pos
	
	if current_tick > 3 and host.is_grounded():
		return land_cancel_state
	
	for i in range(len(projectile_spawn_ticks)):
		if current_tick == projectile_spawn_ticks[i]:
			host.spawn_object(
				projectiles[i],
				int(projectile_pos[i].x),
				int(projectile_pos[i].y),
				true,
				{"dir": {"x": str(projectile_dirs[i].x), "y": str(projectile_dirs[i].y)}}
			)
	
	if host.opponent.state_machine.state.name == "Knockdown":
		host.opponent.state_machine.state.endless = true
		host.opponent.state_machine.state.iasa_at = -1
