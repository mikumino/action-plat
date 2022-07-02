extends Area2D
var health = 3

func take_damage():
	print(self.name + "\t" + str(health))
	$AnimationPlayer.play("take_damage")
	health -= 1
	if health <= 0:
		die()

func die():
	$AnimationPlayer.play("die")
