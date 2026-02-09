extends Condition

class_name CTargetHidden

@export var distance: float = 10

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.current_target and blackboard.current_target.blackboard.hidden:
		return true
		
	return false
