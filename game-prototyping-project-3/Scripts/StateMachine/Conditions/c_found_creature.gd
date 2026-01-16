extends Condition

class_name CFoundCreature

@export var creature_types: Array[StringName]

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_creatures.size() > 0:
		print("Sees creatures!")
		for other_creature in blackboard.seen_creatures:
			if other_creature.get_type() in creature_types:
				return true
	return false
