extends Node2D

var index = 0
var timer = 0
var bpm = 60

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var l = 60 / bpm
	timer += delta
	if timer > l:
		timer -= l
		var t = get_node("title" + str(index))
		index = (index + 1) % 3
		t.frame = 0
		t.play()
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
