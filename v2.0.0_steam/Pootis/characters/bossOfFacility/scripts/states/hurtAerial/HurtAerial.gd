extends HurtAerial

func _frame_0():
	if host.hp <= 0:
		host.state_machine._change_state("DeathAerial")
