extends Node

class_name State

@export var can_move : bool = true 
var character : CharacterBody2D
var next_state : State
var playback : AnimationNodeStateMachinePlayback

@warning_ignore("unused_parameter")
func state_input(event : InputEvent):
	pass
func on_enter():
	pass
func on_exit():
	pass
func state_process(delta : float):
	pass
