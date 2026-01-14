extends Action

class_name ASetTargetNull

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.current_target = null
