extends Action

class_name AVelocityZero

# Sets creature velocity to zero
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if owning_creature:
		owning_creature.velocity = Vector2.ZERO # Ew, should not need to be done
