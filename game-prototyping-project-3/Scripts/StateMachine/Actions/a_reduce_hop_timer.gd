extends Action

class_name AReduceHopTimer

# Handles hop timer
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardFrog:
		if blackboard.is_hopping:
			blackboard.hop_timer -= _delta
			if blackboard.hop_timer <= 0:
				if owning_creature is Frog:
					owning_creature.hop_switch()
