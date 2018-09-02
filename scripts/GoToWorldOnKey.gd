extends Node2D

export(String, FILE, "*.tscn") var next_world

func _input(event):
	if event is InputEventKey:
		if !event.pressed:
			get_tree().change_scene(next_world)
