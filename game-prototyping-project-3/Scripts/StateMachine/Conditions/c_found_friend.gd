extends Condition

class_name CFoundFriend

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	# print("Wants to play!")
	if blackboard.seen_creatures.size() > 0:
		# print("Sees creatures!")
		for other_creature in blackboard.seen_creatures:
			if other_creature.get_wants_to_play() and other_creature.get_type() in owning_creature.friend_types and not other_creature.blackboard.hidden:
				print("Other creature wants to play!")
				return true
	return false
