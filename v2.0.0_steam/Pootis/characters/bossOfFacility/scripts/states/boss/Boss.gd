extends CharacterState

var OFFSET_DIST = 50

func _enter():
	host.colliding_with_opponent = false

func _frame_1():
	host.set_pos(host.opponent.get_pos().x + OFFSET_DIST * host.get_opponent_dir(), 0)
	host.set_facing(-host.get_facing_int())
	
	iasa_at = current_tick

func _exit():
	host.colliding_with_opponent = true
