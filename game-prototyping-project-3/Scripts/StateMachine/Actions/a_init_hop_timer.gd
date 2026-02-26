extends Action

class_name AInitHopTimer

@export var hop_sprite: Texture2D

# Handles hop timer
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardFrog:
		blackboard.initialize_hopping(owning_creature.velocity, hop_sprite)
