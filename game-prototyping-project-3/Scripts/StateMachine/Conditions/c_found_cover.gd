extends Condition

class_name CFoundCover


func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_cover.size() > 0:
		# print("Sees creatures!")
		for cover in blackboard.seen_cover:
			if cover:
				return true # Ugly
	return false
