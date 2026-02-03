extends Action

class_name ADropFood

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardPlantCreature:
		if blackboard.has_food:
			owning_creature.spawn_food_nearby()
			blackboard.has_food = false
			blackboard.food_timer = blackboard.food_timer_max
