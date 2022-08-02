extends State
var attack_frames
var prev_animation

func _enter_state(host,state_machine):
	attack_frames = 10
	host.attack_hitbox_collision.set_deferred("disabled", false)
	host.attack_hitbox.get_child(0).visible = true
	prev_animation = host.animation.current_animation
	host.action_animation.play("attack")
	host.animation.play("attack")

func _tick_state(host,state_machine,delta):
	attack_frames -= 1
	if attack_frames <= 0:
		host.attack_hitbox_collision.set_deferred("disabled", true)
		host.attack_hitbox.get_child(0).visible = false
		state_machine.set_state(host, "inactive")

func _exit_state(host,state_machine):
	host.animation.play(prev_animation)

func _on_AttackHitbox_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.take_damage()
