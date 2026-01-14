extends Condition

class_name CWaitTimeZero

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.wait_time <= 0:
		return true
	return false
