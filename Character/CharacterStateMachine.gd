extends Node

class_name CharacterStateMachine

var states : Array[State]

@export var character : CharacterBody2D 
@export var current_state : State 
@export var animation_tree : AnimationTree

func _ready() -> void:
	for child in get_children():
		if child is State : 
			states.append(child)
			child.character = character
			child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("Child "+ child.name +" is not a State for CharacterStateMachine")

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
	current_state.state_process(delta)

func check_if_can_move() -> bool : 
	return current_state.can_move

func switch_states(next_state : State):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	current_state = next_state
	current_state.on_enter()

func _input(event : InputEvent):
	current_state.state_input(event)
