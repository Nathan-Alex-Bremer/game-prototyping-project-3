extends Action

class_name ASetTargetCreature

@export var creature_types: Array[StringName]

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.seen_creatures.size() > 0:
		# print("Sees creatures!")
		for other_creature in blackboard.seen_creatures:
			if other_creature.get_type() in creature_types:
				# Don't target partner
				if blackboard is BlackboardPredator and blackboard.partner and blackboard.partner.creature_name == other_creature.creature_name:
					pass
				# Don't find "hidden" creatures
				if other_creature.blackboard.hidden:
					pass
				blackboard.current_target = other_creature
				return
	print("ERROR: NO CREATURE FOUND")
	blackboard.current_target = null
