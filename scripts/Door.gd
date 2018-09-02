extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export(String, FILE, "*.tscn") var next_world

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Door_body_entered(body):
	if body.name == "Player":
		if body.has_mail:
			print("lets go")
			get_tree().change_scene(next_world)
		else:
			print("Where is my mail?")
