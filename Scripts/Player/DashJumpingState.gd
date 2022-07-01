extends State
var orientation
var dash_frames

func _enter_state(host,state_machine):
	orientation = sign(host.x_input) if host.x_input != 0 else -1 if host.sprite.flip_h else 1
	dash_frames = 20

func _tick_state(host,state_machine,delta):
	dash_frames -= 1
	if dash_frames == 0:
		if host.is_on_floor():
			state_machine.set_state(host, "idle")
		else:
			state_machine.set_state(host, "falling")
	# Horizontal movement
	if host.x_input == 0:
		if host.motion.x > 0:
			host.motion.x = max(host.motion.x - host.acceleration, 0)
		if host.motion.x < 0:
			host.motion.x = min(host.motion.x + host.acceleration, 0)

func _exit_state(host,state_machine):
	host.sprite.scale.y = 1
	#host.motion.x = orientation*host.move_speed
