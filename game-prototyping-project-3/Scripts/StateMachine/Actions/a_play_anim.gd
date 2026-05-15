extends Action

class_name APlayAnim

@export var anim_name: StringName

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	owning_creature.play_animation(anim_name)
