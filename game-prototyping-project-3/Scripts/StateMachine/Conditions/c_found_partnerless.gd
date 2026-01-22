extends Condition

class_name CFoundPartnerless

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	# print("Wants to play!")
	if blackboard.seen_creatures.size() > 0:
		# print("Sees creatures!")
		for other_creature in blackboard.seen_creatures:
			if other_creature.blackboard is BlackboardPredator:
				if other_creature.get_type() in owning_creature.friend_types and (not other_creature.blackboard.partner):
					print("Other creature has no partner!")
					return true
	return false
