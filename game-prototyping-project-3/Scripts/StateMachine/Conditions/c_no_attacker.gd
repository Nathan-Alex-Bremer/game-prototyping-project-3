extends Condition

class_name CNoAttacker

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.current_attacker == null:
		return true
	return false
