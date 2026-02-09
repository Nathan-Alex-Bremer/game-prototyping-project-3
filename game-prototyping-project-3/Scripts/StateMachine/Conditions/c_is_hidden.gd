extends Condition

class_name CIsHidden

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.hidden:
		return true
	return false
