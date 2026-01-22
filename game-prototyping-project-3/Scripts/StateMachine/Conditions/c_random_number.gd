extends Condition

class_name CRandomNumber

@export var min: int = 1
@export var max: int = 2
@export var max_acceptable: int = 1

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	var rand = randi_range(min, max)
	if rand <= max_acceptable:
		return true
	return false
