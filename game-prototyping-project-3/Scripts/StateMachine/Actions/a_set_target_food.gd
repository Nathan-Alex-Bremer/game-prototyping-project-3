extends Action

class_name ASetTargetFood

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.seen_food.size() > 0:
		print("Hungry!")
		blackboard.current_target = blackboard.seen_food[0]
		return
	else:
		print("ERROR: NO FOOD FOUND")
		blackboard.current_target = null
