extends Action

class_name AReducePoisonTimer

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardPlantCreature:
		if blackboard.has_poison:
			return
		
		blackboard.poison_timer -= _delta
		if blackboard.poison_timer <= 0:
			print("Poison regrown!")
			blackboard.has_poison = true
