extends Action

class_name ASetTargetPartnerAttacker

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard is BlackboardPredator:
		if not blackboard.partner: # If there is no partner, skip
			return
		
		# Set target to partner's current target
		if not blackboard.partner.blackboard.current_attacker: # If the partner's attacker is gone, skip
			return
			
		blackboard.current_target = blackboard.partner.blackboard.current_attacker
