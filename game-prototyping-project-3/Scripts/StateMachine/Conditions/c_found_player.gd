extends Condition

class_name CFoundPlayer

@export var creature_types: Array[StringName]

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_players.size() > 0:
		for player in blackboard.seen_players:
			if player:
				return true
	return false
