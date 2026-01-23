extends Action

class_name AReduceFoodTimer

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardPlantCreature:
		if blackboard.has_food:
			return
		
		blackboard.food_timer -= _delta
		if blackboard.food_timer <= 0:
			blackboard.has_food = true
