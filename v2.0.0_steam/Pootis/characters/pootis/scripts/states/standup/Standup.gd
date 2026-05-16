extends CharacterState

func _enter():
	var mult = -host.get_facing_int()
	
	host.set_facing(mult)
