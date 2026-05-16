extends "res://Pootis/mechanics/utils/CharacterStateAnimatedThumbnail.gd"

export var _c_Pootis_Vars = 0
export (Array, PackedScene) var particles
export (Array, Vector2) var particles_position_offset
export (Array, int) var particles_tick_start
export (Array, bool) var continuous_spawn

var spawned = []

export (Array, Vector2) var velocities
export (Array, int) var velocity_apply_ticks

onready var throw_box = $ThrowBox

const IS_GRAB = true

var grabbed = false

var released = false

export var _c_Throw_Data = 0
export var release = false
export var release_frame = - 1
export var use_start_throw_pos = true
export var start_throw_pos_x = 0
export var start_throw_pos_y = 0
export var use_release_throw_pos = true
export var release_throw_pos_x = 0
export var release_throw_pos_y = 0

export var _c_Release_Data = 0
export var hitstun_ticks: int = 0

export var knockback: String = "1.0"
export var dir_x: String = "1.0"
export var dir_y: String = "0.0"
export var knockdown: bool = true
export var knockdown_extends_hitstun: bool = true
export var aerial_hit_state = "HurtAerial"
export var grounded_hit_state = "HurtGrounded"
export var damage = 10
export var damage_in_combo = - 1
export var reverse = false
export var disable_collision = true
export var ground_bounce = true
export var screenshake_amount = 0
export var screenshake_frames = 0
export var hits_otg = false
export var increment_combo = true
export var hard_knockdown = false
export var force_grounded = false
export var air_ground_bounce = false
export var wall_slam = false
export var di_modifier = "1.0"
export var minimum_grounded_frames = - 1
export var damage_proration = 0

export (Hitbox.HitHeight) var hit_height = Hitbox.HitHeight.Mid

export var _c_Release_Sound = 0
export (AudioStream) var release_sfx = null
export var release_sfx_volume = - 10.0
export var play_release_sfx_bass = true

export (String, MULTILINE) var misc_data = ""

var hitlag_ticks = 0
var victim_hitlag = 0
var throw = true

var release_sfx_player = null

func _enter():
	host.colliding_with_opponent = false
	released = false

func _tick():
	var cameras = get_tree().get_nodes_in_group("Camera")
	
	for i in range(cameras.size()):
		cameras[i].focused_object = null
		cameras[i].global_position = cameras[i].last_pos
	
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
	
	for i in range(len(velocity_apply_ticks)):
		if velocity_apply_ticks[i] < 0:
			if i > 0:
				if velocity_apply_ticks[i-1] < current_tick:
					apply_custom_grav = true
					continue
		if current_tick == velocity_apply_ticks[i]:
			host.set_grounded(false)
			host.set_vel(str(velocities[i].x), str(velocities[i].y))

func _tick_shared():
	if current_tick == 0:
		throw = true
		
		if reverse and not force_same_direction_as_previous_state:
			host.reverse_state = false
			host.set_facing( - host.get_facing_int())
		host.start_invulnerability()
		released = false
	._tick_shared()
	if not released and release and current_tick + 1 == release_frame:
		_release()
		released = true
	if not released:
		host.opponent.colliding_with_opponent = false
		host.colliding_with_opponent = false
	update_throw_position()

func _tick_after():
	._tick_after()
	if not released and grabbed:
		host.update_data()
		var throw_pos = host.get_global_throw_pos()
		host.opponent.set_pos(throw_pos.x, throw_pos.y)

func _frame_0_shared():
	._frame_0_shared()
	if grabbed:
		host.opponent.change_state("Grabbed")
		if use_start_throw_pos:
			host.throw_pos_x = start_throw_pos_x
			host.throw_pos_y = start_throw_pos_y
		else:
			update_throw_position()
		var throw_pos = host.get_global_throw_pos()
		host.opponent.set_pos(throw_pos.x, throw_pos.y)

func _exit():
	host.colliding_with_opponent = true
	released = false

func spawn_particle(i):
	particles_position_offset[i].x *= host.get_facing_int()
	
	spawn_particle_relative(particles[i], particles_position_offset[i], Vector2.RIGHT * host.get_facing_int())

func _release():
	throw = false
	if use_release_throw_pos:
		host.throw_pos_x = release_throw_pos_x
		host.throw_pos_y = release_throw_pos_y
	else:
		update_throw_position()
	var pos = host.get_global_throw_pos()
	host.opponent.set_pos(pos.x, pos.y)
	host.opponent.update_facing()
	var throw_data = HitboxData.new(self)
	host.opponent.hit_by(throw_data)

	if screenshake_amount > 0 and screenshake_frames > 0 and not host.is_ghost:
		var camera = get_tree().get_nodes_in_group("Camera")[0]
		camera.bump(Vector2(), screenshake_amount, screenshake_frames / 60.0)
	if release_sfx and not ReplayManager.resimulating:
		release_sfx_player.play()
	if play_release_sfx_bass:
		host.play_sound("HitBass")

func setup_audio():
	.setup_audio()
	if release_sfx:
		release_sfx_player = VariableSound2D.new()
		add_child(release_sfx_player)
		release_sfx_player.bus = "Fx"
		release_sfx_player.stream = release_sfx
		release_sfx_player.volume_db = release_sfx_volume

func update_throw_position():
	var frame = host.get_current_sprite_frame()
	if frame in throw_positions:
		var pos = throw_positions[frame]
		host.throw_pos_x = int(pos.x)
		host.throw_pos_y = int(pos.y)
	elif frame in host.throw_positions:
		var pos = host.throw_positions[frame]
		host.throw_pos_x = pos.x
		host.throw_pos_y = pos.y

func _on_ThrowBox_hit_something(obj, hitbox):
	grabbed = true
