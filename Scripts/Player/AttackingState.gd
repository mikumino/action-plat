extends State
var attack_frames

func _enter_state(host,state_machine):
	attack_frames = 10
	host.action_animation.play("attack")

func _tick_state(host,state_machine,delta):
	attack_frames -= 1
	if attack_frames <= 0:
		state_machine.set_state(host, "inactive")

func _exit_state(host,state_machine):
	pass

func _on_AttackHitbox_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
