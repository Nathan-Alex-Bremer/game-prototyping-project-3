extends Action

class_name ASetCollisionNone

@export var val: bool = true

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	owning_creature.set_collision_layer_value(1, false)
	owning_creature.set_collision_layer_value(2, false)
	owning_creature.set_collision_layer_value(3, false)
