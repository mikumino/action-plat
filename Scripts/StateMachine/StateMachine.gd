class_name StateMachine
extends Node

var states := {}

var current_state : State
var host

# Public methods

func _ready():
	fill_state_dict()	# on ready, every child of the state machine will be added to the states dict

func tick_states(host,delta):
	if current_state:	# if current state exists
		current_state._tick_state(host,self,delta)

func set_state(host, next_state_id:String):
	if current_state != null:
		current_state._exit_state(host,self)
	if not states.has(next_state_id):
		printerr("State Machine error: State '%s' does not exist" % next_state_id)
	current_state = states.get(next_state_id)
	current_state._enter_state(host, self)

func fill_state_dict():
	for state in get_children():	# your states need to be children of the state machine !!!
		if state.id:
			states[state.id] = state
	
