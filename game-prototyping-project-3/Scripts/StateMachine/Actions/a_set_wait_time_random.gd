extends Action

class_name ASetWaitTimeRandom

@export var min_time: float = 0.0
@export var max_time: float = 1.0

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.wait_time = randf_range(min_time, max_time)
