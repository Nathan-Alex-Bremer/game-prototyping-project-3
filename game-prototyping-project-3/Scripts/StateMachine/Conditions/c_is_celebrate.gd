extends Condition

class_name CIsCelebrate

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.celebrate:
		return true
	return false
