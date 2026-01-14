extends Action

class_name AEat

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	var found_areas = %EatRadius.get_overlapping_areas()
	
	for area in found_areas:
		if area.is_in_group("food"):
			blackboard.seen_food.erase(area) # Does the exited event already handle this???
			area.consume(owning_creature)
			blackboard.current_target = null
			break
