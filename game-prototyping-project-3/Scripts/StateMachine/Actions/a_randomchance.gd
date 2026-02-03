extends Action

# Special Condition which inverts the value of another condition
class_name ARandomChance

@export var base_action: Condition
@export var min: int = 1
@export var max: int = 2
@export var max_acceptable: int = 1

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	var rand = randi_range(min, max)
	if rand <= max_acceptable:
		base_action.act(blackboard, owning_creature, owning_state, _delta)
