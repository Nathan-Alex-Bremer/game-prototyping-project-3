extends Action

class_name ASetSignal

@export var signal_val: StringName = ""

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.signal_type = signal_val
