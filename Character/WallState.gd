extends State

class_name WallState

@export var landing_state : State
@export var air_state : State 
@export var wall_check : RayCast2D
@export var remain_in_wall : RayCast2D
@export var sprite : Sprite2D

func state_process(delta : float) :
	character.velocity.y += (character.fall_gravity*delta)/32
	
	if(character.is_on_floor()):
		next_state = landing_state
		playback.travel("land")
	if(!remain_in_wall.is_colliding()):
		playback.travel("falling")
		next_state = air_state
	
	
	

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump") && remain_in_wall.rotation_degrees == 0 && Input.is_action_pressed("move_left") && !Input.is_action_pressed("move_right")):
		jump()
	elif(event.is_action_pressed("jump") && remain_in_wall.rotation_degrees == 180 && Input.is_action_pressed("move_right") && !Input.is_action_pressed("move_left")):
		jump()
	
	if event.is_action_pressed("move_down"): 
		character.velocity.y *= 4
	elif(event.is_action_released("move_down")):
		character.velocity.y /= 4 

func on_enter():
	character.velocity = Vector2.ZERO
	remain_in_wall.rotation_degrees = wall_check.rotation_degrees
	if remain_in_wall.rotation_degrees == 0 : 
		sprite.flip_h = false
	else :
		sprite.flip_h = true

func on_exit():
	if playback.get_current_node() == "wall_land" :
		playback.next()

func jump():
	character.velocity = Vector2.ZERO
	playback.travel("jump")
	character.velocity.y = character.jump_velocity
	next_state = air_state
