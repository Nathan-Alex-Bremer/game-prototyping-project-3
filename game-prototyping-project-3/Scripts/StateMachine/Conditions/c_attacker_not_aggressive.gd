extends Condition

class_name CAttackerNotAggressive

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:

	if not blackboard.current_attacker.blackboard.aggressive:
		return true
		
	return false
