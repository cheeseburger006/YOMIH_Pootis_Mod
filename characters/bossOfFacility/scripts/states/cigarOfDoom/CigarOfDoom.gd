extends CharacterState

func _exit():
	var kd = host.opponent.state_machine.get_state("Knockdown")
	
	if kd:
		kd.endless = false
		kd.iasa_at = 20
