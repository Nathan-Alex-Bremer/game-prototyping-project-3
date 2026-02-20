extends Action

class_name ASetHidingPlace

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.seen_hiding_places.size() > 0:
		# print("Sees creatures!")
		for hiding_place in blackboard.seen_hiding_places:
			if hiding_place and hiding_place.get_can_hide():
				blackboard.hiding_place = hiding_place
				hiding_place.occupy()
				print("Hidden!")
				return
	else:
		print("ERROR: NO HIDING PLACE FOUND")
