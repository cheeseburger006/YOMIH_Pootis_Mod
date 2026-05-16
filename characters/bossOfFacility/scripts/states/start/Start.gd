extends "res://characters/states/Idle.gd"

export var _c_Pootis_Vars = 0
export (Array, AudioStream) var intro_sfxs

var opp_state

var temp_endless
var temp_iasa_at
var temp_dynamic_iasa

func _enter_shared():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	enter_sfx = intro_sfxs[rng.randi_range(0, len(intro_sfxs)-1)]
	setup_audio()
	
	._enter_shared()

func _tick():
	if not current_tick == 0:
		if current_tick % (iasa_at-1) == 0:
			exit_func()

func _frame_0():
	opp_state = host.opponent.current_state()
	
	temp_endless = opp_state.endless
	temp_iasa_at = opp_state.iasa_at
	temp_dynamic_iasa = opp_state.dynamic_iasa
	
	if opp_state != null:
		opp_state.endless = true
		opp_state.iasa_at = max(iasa_at, opp_state.iasa_at)
		opp_state.dynamic_iasa = false

func exit_func():
	if opp_state != null:
		opp_state.endless = temp_endless
		opp_state.iasa_at = temp_iasa_at
		opp_state.dynamic_iasa = temp_dynamic_iasa
