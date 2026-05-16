extends "res://characters/states/Dash.gd"

func _enter():
	updated = false
	charged = false
	
	auto = false
	data = {"x": "4.5"}
