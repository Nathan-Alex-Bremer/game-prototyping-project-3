extends Action

class_name ARunFromTarget

@export var speed_modifier: float = 1.0

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.current_target:
		print("Owning creature position: " + str(owning_creature.global_position))
		print("Target position: " + str(blackboard.current_target.global_position))
		var direction = owning_creature.global_position - blackboard.current_target.global_position
		owning_creature.velocity = blackboard.current_target.position.direction_to(owning_creature.global_position) * owning_creature.move_speed * speed_modifier
