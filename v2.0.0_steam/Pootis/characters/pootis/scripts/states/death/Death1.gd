extends "res://characters/states/Knockdown.gd"

export var _c_Pootis_Vars = 0
export var  explode_tick = -1
export (Array, PackedScene) var projectiles
export (Array, Vector2) var projectiles_coords

func _tick():
	if current_tick == explode_tick:
		explode()

func explode():
	for i in min(len(projectiles), len(projectiles_coords)):
		host.spawn_object(projectiles[i], projectiles_coords[i].x, projectiles_coords[i].y, true, {"dir": fixed.normalized_vec("0", "0")})
