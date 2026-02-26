extends Action

class_name AHideFrogTongue

# Handles hop timer
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if owning_creature is Frog:
		owning_creature.get_tongue().visible = false
