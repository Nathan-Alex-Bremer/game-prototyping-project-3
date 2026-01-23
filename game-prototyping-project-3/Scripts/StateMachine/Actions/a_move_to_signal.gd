extends Action

class_name AMoveToSignal

@export var speed_modifier: float = 1.0

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.signal_sender:
		var direction = blackboard.signal_sender.global_position - owning_creature.global_position
		owning_creature.velocity = direction.normalized() * owning_creature.move_speed * speed_modifier
