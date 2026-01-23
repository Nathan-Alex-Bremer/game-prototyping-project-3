extends Condition

class_name CHasPartner

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardPredator:
		if blackboard.partner:
			return true
	return false
