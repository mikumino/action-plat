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
onready var animation = $AnimationPlayer
onready var sprite = $Sprite

var flags := {
	"coyote_time_left":0.0,
}

func _ready():
	state_machine.set_state(self, "idle")
	print(state_machine.current_state)
	
func _physics_process(delta):
	_get_movement_input()
	_apply_gravty(delta)
	_apply_movement(delta)
	state_machine.tick_states(self, delta)
	$Label.text = str(state_machine.current_state)
	
func _apply_movement(delta):
	motion = move_and_slide(motion,Vector2.UP)
	
func _apply_gravty(delta):
	motion.y += gravity * gravity_scale * delta
	
func _get_movement_input():
	x_input = int(Input.is_action_pressed("player_right")) - int(Input.is_action_pressed("player_left"))
	y_input = int(Input.is_action_pressed("player_down")) - int(Input.is_action_pressed("player_up"))
