extends Action

class_name AMoveTowardTarget

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.current_target:
		var direction = blackboard.current_target.global_position - owning_creature.global_position
		owning_creature.velocity = direction.normalized() * owning_creature.move_speed
