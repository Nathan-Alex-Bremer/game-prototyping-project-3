extends Condition

class_name CBossWantsToLeave
# Avoids a bunch of annoying conditionals

@export var feisty_val: float = 100
@export var hunger_val: float = 0
@export var health_val: float = 0

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if owning_creature.feisty < feisty_val:
		return false
	if owning_creature.hunger > hunger_val:
		return false
	if owning_creature.hit_points > health_val:
		return false
	return true
