extends Label

@export var state_machine : CharacterStateMachine
@export var wall_check : RayCast2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if wall_check.is_colliding() : 
		text = "WALL"
	else : 
		text = ""
