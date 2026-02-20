extends Condition

class_name CFoundHidingPlace

@export var creature_types: Array[StringName]

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_hiding_places.size() > 0:
		# print("Sees creatures!")
		for hiding_place in blackboard.seen_hiding_places:
			if hiding_place and hiding_place.get_can_hide():
				return true # Ugly
	return false
