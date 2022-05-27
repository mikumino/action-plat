class_name GroundedState
extends "res://Scripts/StateMachine/State.gd"

func _enter_state(host,state_machine):
	pass

func _tick_state(host,state_machine,delta):
	# Falling
	if not host.is_on_floor():
		state_machine.set_state(host, "falling")
	# Jumping
	if Input.is_action_just_pressed("player_jump"): # or host.buffer_timer.get_time_left() > 0
		host.motion.y = -host.jump_power
		state_machine.set_state(host, "jumping")
		return
	# Walking
	if host.x_input != 0:
		state_machine.set_state(host, "walking")
	# Idle
	else:
		state_machine.set_state(host, "idle")

func _exit_state(host,state_machine):
	pass