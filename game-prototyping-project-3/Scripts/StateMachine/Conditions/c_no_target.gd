extends Condition

class_name CNoTarget

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.current_target == null:
		return true
	return false
