extends State

func _enter_state(host,state_machine):
	host.animation.play("walk")

func _tick_state(host,state_machine,delta):
	# Falling
	if not host.is_on_floor():
		state_machine.set_state(host, "falling")
		return
	host.flags["coyote_time_left"] = host.coyote_time
	# Jumping
	if Input.is_action_just_pressed("player_jump") or host.buffer_timer.get_time_left() > 0:
		host.motion.y = -host.jump_power
		state_machine.set_state(host, "jumping")
		return
	# Dashing
	if Input.is_action_just_pressed("player_dash"):
		state_machine.set_state(host, "dashing")
	# Horizontal movement
	if host.x_input != 0:
		if host.x_input > 0:
			host.sprite.flip_h = false
			host.attack_hitbox.position.x = 15
			host.attack_hitbox.get_child(0).flip_h = false
			host.direction = Vector2(1, 0)
			host.motion.x = min(host.motion.x + host.acceleration, host.move_speed)
		else:
			host.sprite.flip_h = true
			host.attack_hitbox.position.x = -15
			host.attack_hitbox.get_child(0).flip_h = true
			host.direction = Vector2(-1, 0)
			host.motion.x = max(host.motion.x - host.acceleration, -host.move_speed)
	else:
		if host.motion.x > 0:
			host.motion.x = max(host.motion.x - host.acceleration, 0)
		if host.motion.x < 0:
			host.motion.x = min(host.motion.x + host.acceleration, 0)
	# Idling
	if host.motion.x == 0 and host.x_input == 0:
		print("what")
		state_machine.set_state(host, "idle")
func _exit_state(host,state_machine):
	pass
