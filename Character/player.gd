extends CharacterBody2D
class_name Player

@export var speed : int = 300
@export var jump_height : float 
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var wall_check : RayCast2D = $WallCheck

@onready var jump_velocity : float  = ((2.0*jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0*jump_height) / (jump_time_to_peak * jump_time_to_peak))* -1.0
@onready var fall_gravity : float = ((-2.0*jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

enum Direction {LEFT,RIGHT}
var dir = Direction.RIGHT

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = Vector2.ZERO
func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	check_direction()
	direction = Vector2.ZERO
	
	
	
	if Input.is_action_pressed("move_left") && state_machine.check_if_can_move():
		direction += Vector2.LEFT
	elif Input.is_action_pressed("move_right") && state_machine.check_if_can_move():
		direction += Vector2.RIGHT
	if direction.length() > 0 :
		direction = direction.normalized()
		
	animation_update()
	set_direction()
	velocity.x = direction.x*speed
	
	move_and_slide()
	

func set_direction():
	if dir == Direction.RIGHT:
		wall_check.rotation_degrees = 0
	else:
		wall_check.rotation_degrees = 180

func animation_update() -> void : 
	if velocity.x > 0 : 
		sprite.flip_h = false
	elif velocity.x < 0 :
		sprite.flip_h = true
	animation_tree.set("parameters/Move/blend_position",velocity.x)

func is_near_wall() -> bool : 
	
	return wall_check.is_colliding()

func is_facing_right() -> bool :
	return dir == Direction.RIGHT
	
func check_direction():
	if Input.is_action_pressed("move_left"):
		dir = Direction.LEFT
	elif Input.is_action_pressed("move_right"):
		dir = Direction.RIGHT
