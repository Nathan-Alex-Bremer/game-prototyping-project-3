extends Condition

class_name CPartnerWantsToPlay

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardPredator:
		if not blackboard.partner:
			return false
		if blackboard.partner.get_wants_to_play():
			return true
	return false
