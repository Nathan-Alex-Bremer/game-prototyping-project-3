extends Action

class_name ASetAttackerNull

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	blackboard.current_attacker = null
