extends Condition

class_name CPartnerState

@export var state_val: StringName = ""

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardPredator:
		if not blackboard.partner:
			return false
		if blackboard.partner.get_state().name.to_lower() == state_val:
			return true
	return false
