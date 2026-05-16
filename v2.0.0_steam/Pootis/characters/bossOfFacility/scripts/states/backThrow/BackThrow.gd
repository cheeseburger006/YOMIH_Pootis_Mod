extends ThrowState

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
