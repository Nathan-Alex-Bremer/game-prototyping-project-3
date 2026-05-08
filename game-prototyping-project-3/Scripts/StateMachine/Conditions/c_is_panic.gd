extends Condition

class_name CIsPanic

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.panic:
		return true
	return false
