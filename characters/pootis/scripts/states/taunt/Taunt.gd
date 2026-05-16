extends "res://characters/states/Taunt.gd"

export var _c_Pootis_Vars = 0
export (Array, PackedScene) var projectiles
export (Array, int) var projectile_ticks
export (Array, Vector2) var projectile_pos
export (Array, Vector2) var projectile_dirs

func _tick():
	for i in range(len(projectile_ticks)):
		if current_tick == projectile_ticks[i]:
			host.spawn_object(
				projectiles[i],
				int(projectile_pos[i].x),
				int(projectile_pos[i].y),
				true,
				{
					"dir": {
						"x": str(projectile_dirs[i].x * host.get_facing_int()),
						"y": str(projectile_dirs[i].y)
					}
				}
			)
