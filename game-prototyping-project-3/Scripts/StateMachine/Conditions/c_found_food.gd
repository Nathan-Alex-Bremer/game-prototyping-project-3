extends Condition

class_name CFoundFood

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_food.size() > 0:
		print("Hungry!")
		return true
	return false
