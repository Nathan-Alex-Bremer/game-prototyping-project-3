extends Condition

class_name CIsSatisfied

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardBoss:
		if blackboard.satisfied:
			return true
	return false
