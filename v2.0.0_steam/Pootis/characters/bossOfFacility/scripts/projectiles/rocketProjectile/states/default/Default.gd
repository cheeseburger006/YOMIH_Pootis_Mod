extends DirProjectileDefault

export var _c_Pootis_Vars = 0
export (Array, PackedScene) var particles
export (Array, Vector2) var particles_position_offset
export (Array, int) var particles_tick_start
export (Array, bool) var continuous_spawn

var spawned = []

func _enter():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	custom_grav = str(rng.randf_range(0.2, 0.5))
	
	host.collision_box.hide()
	host.hurtbox.hide()

func _tick():
	var min_len = min(min(len(particles), len(particles_position_offset)), len(particles_tick_start))
	var just_spawned = false
	
	for i in range(min_len):
		if particles_tick_start[i] < 0:
			continue
		if current_tick == particles_tick_start[i]:
			spawned.insert(i, true)
			just_spawned = true
		
		if i < len(spawned):
			if spawned[i]:
				if just_spawned:
					spawn_particle(i)
				if not just_spawned and continuous_spawn[i]:
					spawn_particle(i)
	
	if host.is_grounded():
		return fallback_state

func spawn_particle(i):
	particles_position_offset[i].x *= host.get_facing_int()
	
	spawn_particle_relative(particles[i], particles_position_offset[i], Vector2.RIGHT * host.get_facing_int())
