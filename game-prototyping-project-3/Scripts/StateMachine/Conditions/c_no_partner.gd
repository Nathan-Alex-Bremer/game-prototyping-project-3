extends Condition

class_name CNoPartner

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardPredator:
		if not blackboard.partner:
			return true
	return false
