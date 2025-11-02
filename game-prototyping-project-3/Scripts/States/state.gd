class_name State
extends Resource

# Variables
@export var enter_actions: Array[Action] = []
@export var exit_actions: Array[Action] = []
@export var update_actions: Array[Action] = []
@export var physics_update_actions: Array[Action] = []

@export var transitions: Array[Transition] = []

# Signals
# signal Transitioned

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Actions
func enter(blackboard: Blackboard) -> void:
	for action in enter_actions:
		action.act(blackboard)
	
func exit(blackboard: Blackboard) -> void:
	for action in exit_actions:
		action.act(blackboard)

func update(blackboard: Blackboard):
	for action in update_actions:
		action.act(blackboard)
	
	check_transitions(blackboard)

func physics_update(blackboard: Blackboard):
	for action in physics_update_actions:
		action.act(blackboard)

# Transitions

func check_transitions(blackboard: Blackboard):
	for transition in transitions:
		if transition.condition.evaluate(blackboard):
			blackboard.state_machine.transition_to_state(transition.next_state)
			break
