extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Spikes_body_entered(body):
	if body.name == "Player":
		global_sounds.play_spikes()
		# $Sfx.play()
		print("restart level")
		get_tree().reload_current_scene()
