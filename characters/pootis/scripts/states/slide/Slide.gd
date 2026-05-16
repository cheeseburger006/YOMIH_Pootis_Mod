extends CharacterState

var vel_threshold = {
	"x": 0.1,
	"y": 0.1
};

func _ready():
	pass

func _tick():
	var vel = host.get_vel()

	if abs(float(vel.x)) <= vel_threshold.x and abs(float(vel.y)) <= vel_threshold.y:
		endless = false

func _exit():
	endless = true
