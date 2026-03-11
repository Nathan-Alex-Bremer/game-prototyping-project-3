extends Condition

class_name CIsRaining

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if GameState.raining:
		return true
	return false
