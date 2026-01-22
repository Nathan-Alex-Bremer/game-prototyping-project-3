extends Action

class_name ASetPartner

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardPredator:
		if blackboard.seen_creatures.size() > 0:
			# print("Set partner: Sees creatures!")
			for other_creature in blackboard.seen_creatures:
				if other_creature.get_type() in owning_creature.friend_types and (not other_creature.blackboard.partner):
					blackboard.partner = other_creature # This might cause trouble! Beware!
					print("Partner: " + blackboard.partner.creature_name)
					other_creature.blackboard.partner = owning_creature
				return
		else:
			print("ERROR: NO CREATURE FOUND")
			blackboard.current_target = null
