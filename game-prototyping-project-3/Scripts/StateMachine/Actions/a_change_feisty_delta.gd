extends Action

class_name AChangeFeistyDelta

@export var amount: float
@export var scalable: bool

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	owning_creature.change_feisty(amount * _delta, scalable)
