extends KinematicBody2D

# Physics
var motion := Vector2.ZERO
var gravity = 5
var gravity_scale = 100

# Movement vars
var acceleration := 750.0
var move_speed := 80.0
var jump_power := 160.0
var min_jump_power := 40.0
var x_input := 0
var y_input := 0

# QOL movement vars
var can_coyote = true
var coyote_time := 0.1

# Misc vars
onready var state_machine = $StateMachine

func _ready():
	state_machine.set_state(self, "idle")
	print(state_machine.current_state)
	
