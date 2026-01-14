extends Condition

class_name CHitPointsGreaterThan

@export var val: float = 10

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if owning_creature.hit_points >= val:
		return true
	return false
