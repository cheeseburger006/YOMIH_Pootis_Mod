extends CharacterState

export var _c_Pootis_Vars = 0
export (float) var vel_threshold

onready var throwbox = $ThrowBox

func _tick():
	var vel = host.get_vel()
	
	if float(vel.y) >= vel_threshold:
		throwbox.activate()
		throwbox.always_on = true

func _exit():
	throwbox.always_on = false
