extends Condition

class_name CFoundFoodLure

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_food.size() > 0:
		for food in blackboard.seen_food:
			if food.get_lure():
				blackboard.signal_sender = food # Gross, but just sets the current target to the food
				return true
	return false
