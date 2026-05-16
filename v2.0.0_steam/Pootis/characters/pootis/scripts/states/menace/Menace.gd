extends ParryState

const MIN_SPEED_RATIO = "0.5"
var MAX_SPEED_RATIO = "1.25"

export var _c_Pootis_Vars = 0
export var dir_x = 1
export var dash_speed = 100
export var fric = "0.05"
export var back_penalty = 5
export var startup_lag = 0
export var speed_limit = "40"

var dash_force = "0"
var dist_ratio = "0.2"

var new_vel_x = 0

func _enter():
	if data == null:
		data = {
			"Melee Parry Timing": {
				"count": 0
			},
			"Block Height": {
				"x": 1,
				"y": 0
			}
		}
	else:
		data["Melee Parry Timing"] =  {
				"count": 0
		}
		data["Block Height"] =  {
				"x": 1,
				"y": 0
		}
	
	if dir_x < 0:
		MAX_SPEED_RATIO = "1.0"
		host.add_penalty(back_penalty)
		host.reset_momentum()
	else :
		MAX_SPEED_RATIO = "1.25"
		beats_backdash = true

		starting_iasa_at = 100
		iasa_at = starting_iasa_at
	if startup_lag != 0:
		return 
	var dash_force = str(dir_x * dash_speed)
	
	new_vel_x = fixed.mul(str(host.get_facing_int()), fixed.mul(dash_force, fixed.add(fixed.mul(dist_ratio, fixed.sub(MAX_SPEED_RATIO, MIN_SPEED_RATIO)), MIN_SPEED_RATIO)))

func _tick():
	endless = true
	
	host.apply_x_fric(fric)
	host.apply_grav()
	host.apply_forces()
	
	host.limit_speed(speed_limit)
	
	host.set_vel(new_vel_x, "0")
	
	if current_tick % 19 == 0:
		sfx_tick = current_tick+1

func get_whiffed_block():
	return true
	
func matches_hitbox_height(hitbox, parry_type = null):
	if parry_type == null:
		parry_type = self.parry_type
	match hitbox.hit_height:
		Hitbox.HitHeight.High:
			return parry_type == ParryHeight.High or parry_type == ParryHeight.Both
		Hitbox.HitHeight.Mid:
			return parry_type == ParryHeight.High or parry_type == ParryHeight.Both
		Hitbox.HitHeight.Low:
			return parry_type == ParryHeight.Low or parry_type == ParryHeight.Both
	return false
