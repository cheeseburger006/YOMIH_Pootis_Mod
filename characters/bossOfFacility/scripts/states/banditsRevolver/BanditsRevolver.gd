extends CharacterState

export var _c_Pootis_Vars = 0
export (Array, PackedScene) var particles
export (Array, Vector2) var particles_position_offset
export (Array, int) var particles_tick_start

var spawned = []

func _tick():
	var max_len = min(min(len(particles), len(particles_position_offset)), len(particles_tick_start))
	
	for i in range(max_len):
		if particles_tick_start[i] <= 0:
			continue
		if current_tick == particles_tick_start[i]:
			spawned.insert(i, true)
		
		if i < len(spawned):
			if spawned[i]:
				spawn_particle(i)

func spawn_particle(i):
	particles_position_offset[i].x *= host.get_facing_int()
	
	spawn_particle_relative(particles[i], particles_position_offset[i], Vector2.RIGHT * host.get_facing_int())

func _exit():
	if enter_sfx_player:
		enter_sfx_player.stop()
