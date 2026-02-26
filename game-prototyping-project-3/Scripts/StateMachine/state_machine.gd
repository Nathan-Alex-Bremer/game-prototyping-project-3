extends Node
class_name StateMachine

@export var initial_state: MonsterState
var current_state: MonsterState
var states: Dictionary = {}

# Signals
signal state_changed(new_state: MonsterState)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is MonsterState:
			states[child.name.to_lower()] = child
			# child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		
		var transition = current_state.check_transitions()
		if transition != null:
			on_child_transition(transition)
		
	
	
func _physics_process(delta: float) -> void:
	if current_state:
		
		current_state.physics_update(delta)
		
func get_current_state_name() -> StringName:
	return current_state.name.to_lower()

func on_child_transition(new_state_name) -> void:
	
	if new_state_name == "birdstatefleetarget":
		print("State before: " + get_current_state_name())
	
	#if state != current_state:
		#return
		
	var new_state = states.get(new_state_name.to_lower())
		
	if !new_state:
		print("ERROR: No new state: " + new_state_name)
		return
	
	# Only update if the state asking for transition is current state
	if current_state:
		current_state.exit()
		
	# Update current state to new state
	current_state = new_state
	
	state_changed.emit(new_state)
	
	# Call enter function
	# print("New state: " + new_state_name)
	new_state.enter()
	
	
