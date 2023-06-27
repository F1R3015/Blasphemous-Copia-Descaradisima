extends State

class_name GroundState


@export var air_state : State
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
func jump():
	
	character.velocity.y = character.jump_velocity
	next_state = air_state
	playback.travel("jump")

func state_process(delta : float):
	if(!character.is_on_floor()):
		next_state = air_state
		playback.travel("falling")
