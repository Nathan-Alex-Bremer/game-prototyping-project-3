extends Action

class_name AConditionalSpriteChange

@export var condition: Condition
@export var new_sprite: Texture2D

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if condition.evaluate(blackboard, owning_creature, owning_state, _delta):
		owning_creature.change_sprite(new_sprite)
