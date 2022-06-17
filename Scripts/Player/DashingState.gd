extends State
var dash_frames
var orientation

func _enter_state(host,state_machine):
	dash_frames = 10
	host.sprite.scale.y = 0.5
	orientation = sign(host.x_input) if host.x_input != 0 else -1 if host.sprite.flip_h else 1

func _tick_state(host,state_machine,delta):
	print(dash_frames)
	dash_frames -= 1
	host.motion.x = orientation * 200
	if dash_frames == 0:		
		# Air
		if not host.is_on_floor():
			state_machine.set_state(host, "falling")
		# Ground
		else:
			state_machine.set_state(host, "walking")
		return

func _exit_state(host,state_machine):
	host.sprite.scale.y = 1
	host.motion.x = orientation*host.move_speed
