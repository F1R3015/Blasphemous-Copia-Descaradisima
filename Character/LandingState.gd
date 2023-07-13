extends State

class_name LandingState


@export var landing_animation_name : String = "land"
@export var ground_state : State
@export var air_state : State

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if( anim_name == landing_animation_name):
		next_state = ground_state

func jump():
	character.velocity.y = character.jump_velocity
	next_state = air_state
	playback.travel("jump")

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()

func on_exit():
	playback.next()
