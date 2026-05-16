extends DirProjectileDefault

func _enter():
	if not data:
		data = {
			"dir": {
				"x": "0",
				"y": "0"
			}
		}

func fizzle():
	hit_something = true
	terminate_hitboxes()
	hit_something_tick = current_tick
	loop_animation = false
