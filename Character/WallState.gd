extends State

class_name WallState

@export var landing_state : State
@export var air_state : State 
@export var wall_check : RayCast2D

func state_process(delta : float) :
	character.velocity.y += (character.fall_gravity*delta)/32
	
	if(character.is_on_floor()):
		next_state = landing_state
		playback.travel("land")
	
	
	
	

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && character.is_facing_right() && Input.is_action_pressed("move_left")):
		jump()
	elif(event.is_action_pressed("jump") && !character.is_facing_right() && Input.is_action_pressed("move_right")):
		jump()

func on_enter():
	character.velocity = Vector2.ZERO



func jump():
	wall_check.rotate(PI)
	character.velocity = Vector2.ZERO
	playback.travel("jump")
	character.velocity.y = character.jump_velocity
	next_state = air_state
