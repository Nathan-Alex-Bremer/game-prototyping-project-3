extends Condition

class_name CInCover


func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.entered_cover > 0:
		return true # Ugly
	return false
