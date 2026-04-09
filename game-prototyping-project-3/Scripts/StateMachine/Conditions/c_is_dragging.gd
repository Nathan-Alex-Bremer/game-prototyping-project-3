extends Condition

class_name CIsDragging

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if owning_creature.is_dragging:
		return true
	return false
