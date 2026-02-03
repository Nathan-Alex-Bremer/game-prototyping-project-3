extends Condition

class_name CHasPoison

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardPlantCreature:
		if blackboard.has_poison:
			return true
	return false
