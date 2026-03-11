extends Action

class_name ASetTargetCover

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.seen_cover.size() > 0:
		for cover in blackboard.seen_cover:
			if cover:
				blackboard.current_target = cover
				return
	print("ERROR: NO COVER FOUND")
	blackboard.current_target = null
