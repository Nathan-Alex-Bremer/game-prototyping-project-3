extends Condition

class_name CFoundCreature

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_creatures.size() > 0:
		print("Sees creatures!")
		for other_creature in blackboard.seen_creatures:
			return true
	return false
