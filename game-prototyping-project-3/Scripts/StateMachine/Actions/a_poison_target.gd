extends Action

class_name APoisonTarget

@export var damage: float = 10

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	var target = blackboard.current_target
	if target is Creature:
				target.is_poisoned = true
				target.poison_ticks_remaining = 3
				target.poison_damage_timer = 1
				target.toggle_poison_color(true)
