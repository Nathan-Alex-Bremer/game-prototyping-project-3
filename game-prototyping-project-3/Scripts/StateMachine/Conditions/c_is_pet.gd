extends Condition

class_name CIsPet

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.is_pet:
		return true
	return false
