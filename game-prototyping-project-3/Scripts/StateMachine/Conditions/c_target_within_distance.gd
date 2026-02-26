extends Condition

class_name CTargetWithinDistance

@export var distance: float = 10

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.current_target:
		var direction = blackboard.current_target.global_position - owning_creature.global_position
			
		if direction.length() <= distance:
			return true
			
	return false
