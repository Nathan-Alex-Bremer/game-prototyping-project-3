extends Action

class_name ACalcWantsToPlay

@export var min_feisty: float = 20
@export var max_feisty: float = 60
@export var min_food: float = 25
@export var max_tired: float = 60

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	# Update wants to play
	if owning_creature.feisty > min_feisty and owning_creature.feisty < max_feisty and owning_creature.hunger > min_food and owning_creature.tired < max_tired:
		blackboard.wants_to_play = true
	else:
		blackboard.wants_to_play = false
