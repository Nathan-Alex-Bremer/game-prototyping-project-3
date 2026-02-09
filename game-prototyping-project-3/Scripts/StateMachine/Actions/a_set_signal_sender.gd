extends Action

class_name ASetSignalSender

@export var signal_sender_val: Node2D

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.signal_sender = signal_sender_val
