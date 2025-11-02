class_name StateMachine
extends Node2D

@export var initial_state: State
var current_state: State
var states: Dictionary = {}
@export var blackboard: Blackboard # TODO: Set this thing up

enum STATES {
	WANDER,
	IDLE
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#for child in get_children():
		#if child is State:
			#states[child.name.to_lower()] = child
			#child.Transitioned.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter(blackboard)
		current_state = initial_state


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_state:
		current_state.update(blackboard)
	blackboard.increment_state_time(delta)
	
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(blackboard)

func transition_to_state(new_state: State) -> void:
	
	# Only update if the state asking for transition is current state
	if current_state:
		current_state.exit(blackboard)
		
	if !new_state:
		print("ERROR: No new state!")
		return
	
	# Update current state to new state
	current_state = new_state
	# Call enter function
	new_state.enter(blackboard)
	
	
	blackboard.reset_state_time()
	
func pick_new_state(new_state: int) -> State:
	
