extends Action

class_name ASetTargetFriend

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.wants_to_play:
			# print("Wants to play!")
			if blackboard.seen_creatures.size() > 0:
				# print("Sees creatures!")
				for other_creature in blackboard.seen_creatures:
					if other_creature.get_wants_to_play() and other_creature.get_type() in owning_creature.friend_types:
						print("Other creature wants to play!")
						blackboard.current_target = other_creature
						return
			else:
				print("ERROR: NO FRIEND FOUND")
				blackboard.current_target = null
