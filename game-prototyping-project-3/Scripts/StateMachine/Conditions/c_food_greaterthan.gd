extends Condition

class_name CFoodGreaterThan

@export var val: float = 0

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if owning_creature.hunger >= val:
		return true
	return false
