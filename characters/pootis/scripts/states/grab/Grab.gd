extends "res://characters/states/Grab.gd"

export var _c_Pootis_Vars = 0
export (Array, int) var change_throwbox_ticks
export (Array, Vector2) var throwbox_pos
export (Array, Vector2) var throwbox_dim

func _enter():
	host.colliding_with_opponent = false
	throw_box.throw_state = back_throw_state

func _exit():
	host.colliding_with_opponent = true

func _frame_9():
	throw_techable = true

func _frame_13():
	throw_techable = false

func _tick():
	for i in len(change_throwbox_ticks):
		if current_tick == change_throwbox_ticks[i]:
			throw_box.x = throwbox_pos[i].x
			throw_box.y = throwbox_pos[i].y
			
			throw_box.width = throwbox_dim[i].x
			throw_box.height = throwbox_dim[i].y
