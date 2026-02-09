extends Condition

class_name CFoundSignal
# For picking up on signals produced by other creatures

@export var creature_types: Array[StringName]
@export var signal_val: StringName

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	if blackboard.seen_creatures.size() > 0:
		# print("Sees creatures!")
		for other_creature in blackboard.seen_creatures:
			if other_creature.blackboard.signal_type == signal_val:
				blackboard.signal_sender = other_creature # VERY BAD! Don't do this!
				return true
	return false
