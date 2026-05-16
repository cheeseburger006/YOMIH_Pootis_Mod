extends "res://characters/states/Grab.gd"

func _enter():
	host.colliding_with_opponent = false
	throw_box.throw_state = forward_throw_state

func _exit():
	host.colliding_with_opponent = true
