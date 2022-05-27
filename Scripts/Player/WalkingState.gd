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
	if Input.is_action_just_pressed("player_jump"): # or host.buffer_timer.get_time_left() > 0
		host.motion.y = -host.jump_power
		state_machine.set_state(host, "jumping")
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
	# Idling
	if host.motion.x == 0:
		state_machine.set_state(host, "idle")
func _exit_state(host,state_machine):
	pass