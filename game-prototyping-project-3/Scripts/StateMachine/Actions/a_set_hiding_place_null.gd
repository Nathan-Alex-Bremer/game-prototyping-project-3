extends Action

class_name ASetHidingPlaceNull

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.hiding_place.unoccupy() # TODO: This should account for whether there are multiple hidden creatures, or each bush should only be able to hide one
	blackboard.hiding_place = null
