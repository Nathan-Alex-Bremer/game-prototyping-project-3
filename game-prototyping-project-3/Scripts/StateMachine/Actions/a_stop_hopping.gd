extends Action

class_name AStopHopping

# Handles hop timer
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardFrog:
		blackboard.is_hopping = false
