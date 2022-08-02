extends State

func _enter_state(host,state_machine):
	host.action_animation.play("inactive")

func _tick_state(host,state_machine,delta):
	if Input.is_action_just_pressed("player_attack"):
		state_machine.set_state(host, "attacking")

func _exit_state(host,state_machine):
	pass
