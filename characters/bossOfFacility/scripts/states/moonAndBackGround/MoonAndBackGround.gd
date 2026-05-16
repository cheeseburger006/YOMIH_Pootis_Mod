extends "res://characters/states/Jump.gd"

func _frame_0():
	
	if data is String and data == "homing":
		var dir = host.get_opponent_dir_vec()
		if fixed.gt(dir.y, "-0.34"):
			dir.y = "-0.34"
			dir.x = fixed.mul(str(host.get_facing_int()), "0.94")
		dir = fixed.normalized_vec(dir.x, dir.y)
		data = {
			"x": fixed.round(fixed.mul(dir.x, "100")), 
			"y": fixed.round(fixed.mul(dir.y, "100"))
		}

	if not super_jump:
		interruptible_on_opponent_turn = true
	next_state_on_hold = false
	next_state_on_hold_on_opponent_turn = false
	queue_backdash_check = false
	var vec = xy_to_dir(data["x"], data["y"], "1")
	var length = fixed.vec_len(vec.x, vec.y)
	var full_hop = fixed.gt(length, FULL_HOP_LENGTH)
	var back = fixed.sign(str(data["x"])) != host.get_facing_int() or data["x"] == 0
	squat = is_squat()
	if squat and not back:
		current_tick = 3

	if back and host.combo_count <= 0:
		host.add_penalty(back_full_hop_sadness if full_hop else back_short_hop_sadness)
		backdash_iasa = true
		beats_backdash = false
	else:
		backdash_iasa = false
		beats_backdash = not (host.opponent.current_state().beats_backdash)
		if (host.opponent.current_state().name == "Jump" or host.opponent.current_state().name == "DoubleJump" or host.opponent.current_state().name == "SuperJump"):
			queue_backdash_check = true
	if not squat:
		jump_tick = 1
		jump()
	else:
		jump_tick = 4 if not super_jump else 7
		anim_name = "Landing"

	sfx_tick = jump_tick
