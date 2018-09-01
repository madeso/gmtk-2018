extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const GRAVITY = 100
const JUMP_SPEED = 70
const SKATE_SPEED = 64
const PREPARE_SPEED = 100

var input_down = false
var last_input = false

const ANIM_IDLE = "Idle"
const ANIM_SKATE = "Skate"
const ANIM_PREP = "Prep"
const ANIM_JUMPUP = "JumpUp"
const ANIM_JUMPDOWN = "JumpDown"
const ANIM_FALL = "Fall"

var dx = 0.0
var dy = 0.0

enum State {
	Idle, Skating, Prepare, Jumping, Falling
}

var state = State.Falling

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _input(event):
	if event is InputEventKey:
		if event.pressed:
			input_down = true
		else:
			input_down = false
			
func Jump():
	dy = -JUMP_SPEED

func Smooth(x, target, delta):
	return x + (target-x) * 0.1

func _physics_process(delta):
	var input_pressed = input_down and not last_input
	last_input = input_down
	$Sprite.playing = true

	match state:
		State.Idle:
			dx = 0
			$Sprite.animation = ANIM_IDLE
			if is_on_floor():
				dy = 0
			if input_pressed:
				state = State.Skating
				print("skate")
		State.Skating:
			$Sprite.animation = ANIM_SKATE
			dx = Smooth(dx, SKATE_SPEED, delta)
			if is_on_wall():
				$Sprite.flip_h = not $Sprite.flip_h
			if input_pressed:
				state = State.Prepare
				print("preparing")
			elif is_on_floor():
				dy = 0
			elif dy > 12:
				print("fall " + str(dy))
				state = State.Falling
		State.Prepare:
			$Sprite.animation = ANIM_PREP
			dx = Smooth(dx, PREPARE_SPEED, delta)
			if is_on_wall():
				$Sprite.flip_h = not $Sprite.flip_h
				print("flip prepare")
			if not input_down:
				state = State.Jumping
				Jump()
				print("jump")
		State.Jumping:
			if dy > 0:
				$Sprite.animation = ANIM_JUMPDOWN
			else:
				$Sprite.animation = ANIM_JUMPUP
			if is_on_wall():
				$Sprite.flip_h = not $Sprite.flip_h
				print("wall jump")
				Jump()
			elif is_on_ceiling():
				dy = 0
			elif is_on_floor():
				print("landed on floor")
				state = State.Skating
		State.Falling:
			$Sprite.animation = ANIM_FALL
			dx = 0;
			if is_on_floor():
				dy = 0
				print("to idle")
				state = State.Idle
	
	dy += delta * GRAVITY
	var vel = Vector2(dx,dy)
	if $Sprite.flip_h:
		vel.x = -vel.x
	move_and_slide(vel, Vector2(0,-1))
	dy = vel.y
	
