extends Action

class_name AInitHopTimer

@export var hop_sprite: Texture2D

# Handles hop timer
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if owning_creature is Frog: # Dumb, but this is technically the best way to play the hop sound on start, I think
		owning_creature.play_hop_sound()
	if blackboard is BlackboardFrog:
		blackboard.initialize_hopping(owning_creature.velocity, hop_sprite)
