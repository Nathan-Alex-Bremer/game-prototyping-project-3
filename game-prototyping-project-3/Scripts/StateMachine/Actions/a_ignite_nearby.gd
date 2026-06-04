extends Action

class_name AIgniteNearby

# "Ignite" all nearby hiding places, making them unusable for a time
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.seen_hiding_places.size() > 0:
		print("Hiding place!")
		for hiding_place in blackboard.seen_hiding_places:
			if hiding_place:
				print("Ignite hiding place!")
				hiding_place.ignite()
	
	if blackboard.seen_flowers.size() > 0:
		for flower in blackboard.seen_flowers:
			if flower:
				flower.ignite()
