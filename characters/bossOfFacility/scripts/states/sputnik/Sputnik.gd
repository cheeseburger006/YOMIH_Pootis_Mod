extends CharacterStateAnimatedThumbnail

export var _c_Pootis_Vars = 0
export (int) var random_tp_start_tick
export (int) var random_tp_end_tick
export (Vector2) var span_start
export (Vector2) var span_end

export (Array, Vector2) var gusts
export (Array, int) var gusts_apply

export (int) var final_damage

var MAX_DIST = 150
var OFFSET_DIST = 32

var starting_pos
var facing

var started = false

var obj_to_push = []

var spawn_gusts = false
var spawn_gusts_tick
var spawn_sequence_tick = 0
var gust_to_spawn = 0

func _enter():
	starting_pos = host.get_pos()
	facing = host.get_opponent_dir()

func _exit():
	spawn_gusts = false
	obj_to_push = []
	spawn_sequence_tick = 0
	gust_to_spawn = 0

func _tick():
	if started:
		teleport()
	
	if spawn_gusts:
		if current_tick >= gusts_apply[0]:
			if current_tick + spawn_sequence_tick == gusts_apply[gust_to_spawn]:
				host.opponent.take_damage(final_damage / len(gusts))
				push_obj(gusts[gust_to_spawn])
				gust_to_spawn += 1
			
			if not (gust_to_spawn == len(gusts)):
				current_tick = gusts_apply[0]
				spawn_sequence_tick += 1
			else:
				spawn_gusts = false
	
	if current_tick == random_tp_start_tick and not started:
		started = true
		
		host.start_invulnerability()
		host.colliding_with_opponent = false
	
	if current_tick == random_tp_end_tick and started:
		started = false
		
		host.end_invulnerability()
		host.colliding_with_opponent = true
		
		var opp_pos = host.opponent.get_pos()
		
		if abs(starting_pos.x - opp_pos.x) < MAX_DIST:
			host.set_pos(opp_pos.x - OFFSET_DIST * facing, 0)
		else:
			host.set_pos(starting_pos.x + MAX_DIST * facing, 0)

func teleport():
	var rng = RandomNumberGenerator.new()
	var new_x
	
	rng.randomize()
	
	new_x = rng.randi_range(starting_pos.x + span_start.x, starting_pos.x + span_end.x)
	host.set_pos(new_x, host.get_pos().y)

func push_obj(gust):
	for obj in obj_to_push:
		if obj is BaseObj:
			obj.apply_force_relative(str(host.get_opponent_dir()*gust.x), str(gust.y))

func _on_Hitbox_hit_something(obj, hitbox):
	spawn_gusts_tick = current_tick
	spawn_gusts = true
	obj_to_push.append(obj)
