extends Condition

class_name CWantsToPlay

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.wants_to_play:
		return true
	return false
