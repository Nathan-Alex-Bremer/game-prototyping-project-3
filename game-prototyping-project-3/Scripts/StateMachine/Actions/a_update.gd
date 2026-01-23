extends Action

class_name AUpdate

@export var food_change: float
@export var feisty_change: float
@export var tired_change: float

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	owning_creature.change_food(food_change * _delta, true)
	owning_creature.change_feisty(feisty_change * _delta, true)
	owning_creature.change_tired(tired_change * _delta, true)
