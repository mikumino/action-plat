class_name State
extends Node

export var id := ""

func _ready():
	id = name.to_lower()

func _enter_state(host,state_machine):
	pass

func _tick_state(host,state_machine,delta):
	pass

func _exit_state(host,state_machine):
	pass
