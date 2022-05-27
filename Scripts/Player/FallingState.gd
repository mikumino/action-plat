extends State

func _enter_state(host,state_machine):
	pass

func _tick_state(host,state_machine,delta):
	if host.is_on_floor():
		host.can_coyote = true
		if host.motion.x != 0: # set the state to walking if they're moving
			state_machine.set_state(host, "walking")
		else: # return to idle otherwise
			state_machine.set_state(host, "idle")
		return
	# Horizontal movement
	var velocity = host.acceleration * host.x_input * delta
	if host.x_input != 0:
		if host.x_input > 0:
			host.sprite.flip_h = false
		else:
			host.sprite.flip_h = true
		host.motion.x += velocity
		host.motion.x = clamp(host.motion.x,-host.move_speed,host.move_speed)
	else:
		velocity = host.acceleration * sign(host.motion.x) * delta * 2
		host.motion.x -= velocity if abs(velocity) < abs(host.motion.x) else host.motion.x
func _exit_state(host,state_machine):
	pass
