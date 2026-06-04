extends Condition

class_name CHasPollen

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardMoth:
		if blackboard.has_pollen:
			return true
	return false
