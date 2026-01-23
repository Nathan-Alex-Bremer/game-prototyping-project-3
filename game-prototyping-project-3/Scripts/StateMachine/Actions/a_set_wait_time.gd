extends Action

class_name ASetWaitTime

@export var time_to_wait: float = 1.0

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.wait_time = time_to_wait
