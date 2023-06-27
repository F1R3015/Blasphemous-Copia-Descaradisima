extends State

class_name AirState

@export var ground_state : State
@export var landing_state : State
@export var wall_state : State

func state_process(delta : float):
	
	if(character.is_on_floor()):
		next_state = landing_state
		playback.travel("land")
		
		
	elif(character.is_near_wall()):
		next_state = wall_state
		playback.travel("wall_land")
	else: 
		if character.velocity.y < 0.0 :
			character.velocity.y += character.jump_gravity*delta
		else:
			character.velocity.y += character.fall_gravity*delta
			
	
