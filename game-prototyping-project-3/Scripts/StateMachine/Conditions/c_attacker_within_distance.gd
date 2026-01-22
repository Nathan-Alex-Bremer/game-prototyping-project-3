extends Condition

class_name CAttackerWithinDistance

@export var distance: float = 10

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.current_attacker:
		var direction = blackboard.current_attacker.global_position - owning_creature.global_position
			
		if direction.length() > distance:
			return true
		
	return false
