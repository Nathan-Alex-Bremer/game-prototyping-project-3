extends Action

class_name ASetHidingPlaceNull

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.hiding_place = null
