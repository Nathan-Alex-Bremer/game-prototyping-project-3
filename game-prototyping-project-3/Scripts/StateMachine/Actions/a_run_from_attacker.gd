extends Action

class_name ARunFromAttacker

@export var speed_modifier: float = 1.0

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.current_attacker:
		var direction = blackboard.current_attacker.global_position - owning_creature.global_position
		owning_creature.velocity = direction.normalized() * owning_creature.move_speed * speed_modifier * -1
