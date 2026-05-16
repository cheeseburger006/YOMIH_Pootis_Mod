extends Hitbox

export var _c_Pootis_Vars = 0
export var x_mult = 0
export var y_mult = 0

func _ready():
	connect("hit_something", self, "on_hit_something")

func on_hit_something(obj, hitbox):
	var host = get_parent().host
	var x_facing = 0
	var y_facing = 0
	if host.fighter_owner == null:
		x_facing = host.get_facing_int()
		y_facing = Utils.int_sign(host.get_pos().y - host.opponent.get_pos().y)
	else:
		x_facing = host.fighter_owner.get_facing_int()
		y_facing = Utils.int_sign(host.fighter_owner.get_pos().y - host.fighter_owner.opponent.get_pos().y)

	get_parent().enter_force_dir_x = str(float(get_parent().enter_force_dir_x) * -x_facing * x_mult)
	get_parent().enter_force_dir_y = str(float(get_parent().enter_force_dir_y) * -y_facing * y_mult)
	
	get_parent().apply_enter_force()
