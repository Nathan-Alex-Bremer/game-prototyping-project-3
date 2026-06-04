extends Action

class_name APollinate

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardMoth:
		if blackboard.current_target:
			var target = blackboard.current_target
			var target_blackboard = target.blackboard
			
			if target_blackboard is BlackboardPlantCreature:
				target_blackboard.has_poison = true
				target_blackboard.has_food = true
			
			blackboard.has_pollen = true
