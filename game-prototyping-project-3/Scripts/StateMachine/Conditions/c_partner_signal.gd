extends Condition

class_name CPartnerSignal

@export var signal_val: StringName = ""

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardPredator:
		if not blackboard.partner:
			return false
		if blackboard.partner.blackboard.signal_type == signal_val: # This is not very good code! Make a getter!
			return true
	return false
