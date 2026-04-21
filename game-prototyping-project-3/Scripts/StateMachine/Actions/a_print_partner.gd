extends Action

class_name APrintPartner

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardPredator:
		if blackboard.partner:
			print("Exiting - Partner: " + blackboard.partner.creature_name)
		else:
			print("ERROR: NO PARTNER")
