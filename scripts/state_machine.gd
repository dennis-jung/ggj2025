extends Node
class_name StateMachine

var _states: Dictionary = {}
var _current_state: State = null
@export var initial_state: State
@export var parent: CharacterBody2D

func _ready():
	if !parent:
		printerr("No parent Node provided. Please provide parent node through editor")
		parent = get_parent() # works only, if our FSM is child of root parent
	for child in get_children():
		if child is State:
			child.parent = parent # give child the parent object
			_states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
			
	if initial_state:
		change_state(initial_state.name)


func _physics_process(delta):
	if _current_state:
		_current_state.update_physics(delta)


func  _process(delta: float) -> void:
	if _current_state:
		_current_state.update(delta)
	

func force_change_state(new_state: String):
	var my_state = _states.get(new_state.to_lower())
	
	if !my_state:
		print(new_state + " does not exist")
		
	if _current_state == my_state:
		print("States are the same. Aborting.")
		return
		
	if _current_state:
		var exit_callable = Callable(_current_state, "exit")
		exit_callable.call_deferred()

	my_state.enter()
	_current_state=my_state


func change_state(new_state_name: String, old_state: State = _current_state):
	if _current_state && old_state.name != _current_state.name:
		printerr("Invalid change_state trying from: " + old_state.name + " but currently in: " + _current_state.name)
		return
		
	#if _current_state && _current_state.name.to_lower() == "death":
		#printerr("Invalid change_state. No coming back from death")
		#return
	
	var new_state:State = _states.get(new_state_name.to_lower())
	if !new_state:
		print("No new state found: " + new_state_name)
		return
		
	if _current_state:
		_current_state.exit()
	
	print_debug("New state: " + new_state.name)
	_current_state = new_state
	new_state.enter()
