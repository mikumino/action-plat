extends State

func _enter_state(host,state_machine):
	host.animation.play("jump")

func _tick_state(host,state_machine,delta):
	host.can_coyote = false
	# Ground
	if host.is_on_floor() and host.motion.y > 0:
		if host.motion.x != 0:
			state_machine.set_state(host, "walking")
		else:
			state_machine.set_state(host, "idle")
		return
	if Input.is_action_just_released("player_jump") or host.motion.y > 0:
		host.motion.y = host.motion.y * 0.7
		host.flags["coyote_time_left"] = 0
		state_machine.set_state(host, "falling")
		return
	# Dashing
	if Input.is_action_just_pressed("player_dash"):
		state_machine.set_state(host, "dashing")
	# Horizontal movement
	if host.x_input != 0:
		if host.x_input > 0:
			host.sprite.flip_h = false
			host.motion.x = min(host.motion.x + host.acceleration, host.move_speed)
		else:
			host.sprite.flip_h = true
			host.motion.x = max(host.motion.x - host.acceleration, -host.move_speed)
	else:
		if host.motion.x > 0:
			host.motion.x = max(host.motion.x - host.acceleration, 0)
		if host.motion.x < 0:
			host.motion.x = min(host.motion.x + host.acceleration, 0)
func _exit_state(host,state_machine):
	pass
