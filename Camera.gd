extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func Smooth(x, target, delta):
	return x + (target-x) * 0.1

func _process(delta):
	var player = $"./../Player"
	var player_sprite = $"./../Player/Sprite"
	var p = player.to_global(Vector2(0,0))
	var d = 100
	if player_sprite.flip_h:
		d = -d
	global_position.x = Smooth(global_position.x, p.x - d, delta)
	global_position.y = p.y
