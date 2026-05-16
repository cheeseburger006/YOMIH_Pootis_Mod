extends ObjectState

func _frame_1():
	fizzle()

func fizzle():
	host.disable()
	terminate_hitboxes()
