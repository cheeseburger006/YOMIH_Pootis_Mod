extends Node

static func get_random_state(states = []):
	var rng = RandomNumberGenerator.new()
	var size = len(states)-1
	var i;
	
	rng.randomize()
	
	i = rng.randi_range(0, size)
	
	return states[i]
