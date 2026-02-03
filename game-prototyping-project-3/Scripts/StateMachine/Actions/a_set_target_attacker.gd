extends Action

class_name ASetTargetAttacker

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.current_attacker:
		blackboard.current_target = blackboard.current_attacker
