extends Action

class_name ASetFrogTongue

# Handles hop timer
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if owning_creature is Frog:
		owning_creature.get_tongue().visible = true
		owning_creature.get_tongue().points[1] = (blackboard.current_target.position - owning_creature.position)
