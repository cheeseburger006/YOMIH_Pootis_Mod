extends CharacterState

export var _c_Pootis_Vars = 0
export (Array, Vector2) var applied_forces
export (Array, int) var applied_force_ticks

export (Array, PackedScene) var projectiles
export (Array, int) var projectile_start_ticks
export (Array, Vector2) var projectiles_start_pos
export (Array, Vector2) var projectiles_dir

export (Array, AudioStream) var sfxs
export (Array, int) var sfx_ticks

func _tick():
	for i in max(max(len(applied_force_ticks), len(projectile_start_ticks)), len(sfx_ticks)):
		if i < len(applied_force_ticks):
			if current_tick == applied_force_ticks[i]:
				host.apply_force_relative(str(applied_forces[i].x), str(applied_forces[i].y))
		
		if i < len(projectile_start_ticks):
			if current_tick == projectile_start_ticks[i]:
				host.spawn_object(projectiles[i],
					projectiles_start_pos[i].x,
					projectiles_start_pos[i].y,
					true,
					{
						"dir":
						{
							"x": str(projectiles_dir[i].x * host.get_facing_int()),
							"y": str(projectiles_dir[i].y)
						}
					}
				)
		
		if i < len(sfx_ticks):
			if current_tick == sfx_ticks[i]:
				enter_sfx = sfxs[i]
				setup_audio()
				
				play_enter_sfx()
