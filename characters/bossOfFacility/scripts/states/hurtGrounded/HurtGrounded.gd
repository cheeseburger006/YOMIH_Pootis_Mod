extends HurtGrounded

export var _c_Pootis_Vars = 0
export (Vector2) var death_launch_force

func _enter():
	._enter()
	
	anim_name = "HurtGrounded"

func _frame_0():
	if host.hp <= 0:
		host.set_grounded(false)
		host.apply_force_relative(
			str(fixed.mul(str(death_launch_force.x), data["hitbox"].knockback)),
			str(fixed.mul(str(death_launch_force.y), data["hitbox"].knockback))
		)
		
		host.state_machine._change_state("DeathAerial")
