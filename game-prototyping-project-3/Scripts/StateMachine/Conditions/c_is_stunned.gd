extends Condition

class_name CIsStunned

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.stunned:
		return true
	return false
