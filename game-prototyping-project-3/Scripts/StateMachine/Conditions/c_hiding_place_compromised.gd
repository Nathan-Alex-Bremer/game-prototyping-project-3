extends Condition

class_name CHidingPlaceCompromised

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.hiding_place:
		if not blackboard.hiding_place.get_can_hide():
			print("Hiding place compromised!")
			return true
		return false
	print("No hiding place!")
	return true
