extends Action

class_name AChangeHitPointsDelta

@export var amount: float

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	owning_creature.change_hit_points(amount * _delta)
