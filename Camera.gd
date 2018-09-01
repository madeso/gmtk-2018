extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var p = $"./../Player".to_global(Vector2(0,0))
	global_position.x = p.x
	global_position.y = p.y
