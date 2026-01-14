extends Condition

# Special Condition which inverts the value of another condition
class_name CNot

@export var base_condition: Condition

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if base_condition.evaluate(blackboard, owning_creature, owning_state, _delta):
		return false
	return true
