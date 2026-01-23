extends Action

class_name ASetWantsToPlay

@export var val: bool = true

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.wants_to_play = val
