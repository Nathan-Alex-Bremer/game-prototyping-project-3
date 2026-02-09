extends Condition

class_name CHasSignal

# For signals "beamed" directly into a creature

@export var signal_val: StringName

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.signal_type == signal_val:
		return true
	return false
