extends Action

class_name ASetTargetCreature

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.seen_creatures.size() > 0:
		print("Sees creatures!")
		for other_creature in blackboard.seen_creatures:
			blackboard.current_target = other_creature
			return
	else:
		print("ERROR: NO CREATURE FOUND")
		blackboard.current_target = null
