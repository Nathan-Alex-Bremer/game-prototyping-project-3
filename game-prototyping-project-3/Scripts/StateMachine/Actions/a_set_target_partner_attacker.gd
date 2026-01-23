extends Action

class_name ASetTargetPartnerAttacker

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardPredator:
		if not blackboard.partner:
			return
		
		# Set target to partner's current target
		blackboard.current_target = blackboard.partner.blackboard.current_attacker
