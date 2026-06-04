extends Condition

class_name CFoundFlowers

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_flowers.size() > 0:
		# print("Sees creatures!")
		for flower in blackboard.seen_flowers:
			if flower and not flower.burning:
				return true # Ugly
	return false
