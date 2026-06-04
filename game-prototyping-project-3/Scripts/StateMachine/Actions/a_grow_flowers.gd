extends Action

class_name AGrowFlowers

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardMoth:
		if blackboard.has_pollen:
			owning_creature.spawn_flowers_nearby()
			blackboard.has_pollen = false
