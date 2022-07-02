extends State

func _enter_state(host,state_machine):
	host.animation.play("fall")

func _tick_state(host,state_machine,delta):
	if host.is_on_floor():
		host.can_coyote = true
		if host.motion.x != 0: # set the state to walking if they're moving
			state_machine.set_state(host, "walking")
		else: # return to idle otherwise
			state_machine.set_state(host, "idle")
		return
	# Coyote jump
	if host.flags["coyote_time_left"] > 0.0:
		host.flags["coyote_time_left"] -= delta
		if Input.is_action_just_pressed("player_jump"):
			host.motion.y = -host.jump_power
			state_machine.set_state(host, "jumping")
			return
	# Buffer jump
	if Input.is_action_just_pressed("player_jump"):
		host.buffer_timer.start()
	# Dashing
	if Input.is_action_just_pressed("player_dash"):
		state_machine.set_state(host, "dashing")
	# Horizontal movement
	if host.x_input != 0:
		if host.x_input > 0:
			host.sprite.flip_h = false
			host.attack_hitbox.position.x = 15
			host.direction = Vector2(1, 0)
			host.motion.x = min(host.motion.x + host.acceleration, host.move_speed)
		else:
			host.sprite.flip_h = true
			host.attack_hitbox.position.x = -15
			host.direction = Vector2(-1, 0)
			host.motion.x = max(host.motion.x - host.acceleration, -host.move_speed)
	else:
		if host.motion.x > 0:
			host.motion.x = max(host.motion.x - host.acceleration, 0)
		if host.motion.x < 0:
			host.motion.x = min(host.motion.x + host.acceleration, 0)
func _exit_state(host,state_machine):
	pass
