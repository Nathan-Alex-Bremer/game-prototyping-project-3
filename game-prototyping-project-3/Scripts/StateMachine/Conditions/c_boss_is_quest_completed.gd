extends Condition

class_name CBossIsQuestComplete

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard is BlackboardBoss:
		if blackboard.quest_completed:
			return true
	return false
