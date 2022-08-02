extends KinematicBody2D

# Physics
var motion := Vector2.ZERO
var gravity = 5
var gravity_scale = 100

# Movement vars
var acceleration := 10
var move_speed := 100
var jump_power := 160
var min_jump_power := 40
var x_input := 0
var y_input := 0

# Addl. movement vars
var can_coyote = true
var coyote_time := 0.1
var direction := Vector2(1,0)

# Misc vars
onready var state_machine = $StateMachine
onready var action_state_machine = $ActionStateMachine
onready var animation = $AnimationPlayer
onready var action_animation = $ActionAnimationPlayer
onready var attack_hitbox = $AttackHitbox
onready var attack_hitbox_collision = $AttackHitbox/CollisionShape2D
onready var sprite = $Sprite
onready var buffer_timer = $BufferTimer

var flags := {
	"coyote_time_left":0.0,
}

func _ready():
	state_machine.set_state(self, "idle")
	action_state_machine.set_state(self, "inactive")
	$Camera._set_limits()
	print(state_machine.current_state)
	
func _physics_process(delta):
	_get_movement_input()
	_apply_gravty(delta)
	_apply_movement(delta)
	state_machine.tick_states(self, delta)
	action_state_machine.tick_states(self, delta)
	$Label.text = str(action_state_machine.current_state)
	
func _apply_movement(delta):
	motion = move_and_slide(motion,Vector2.UP)
	
func _apply_gravty(delta):
	motion.y += gravity * gravity_scale * delta
	
func _get_movement_input():
	x_input = int(Input.is_action_pressed("player_right")) - int(Input.is_action_pressed("player_left"))
	y_input = int(Input.is_action_pressed("player_down")) - int(Input.is_action_pressed("player_up"))
