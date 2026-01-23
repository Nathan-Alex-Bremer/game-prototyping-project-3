extends Action

class_name ASetAggressive

@export var val: bool = true

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.aggressive = val
