extends Condition

class_name CIsPoked

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.is_poked:
		return true
	return false
