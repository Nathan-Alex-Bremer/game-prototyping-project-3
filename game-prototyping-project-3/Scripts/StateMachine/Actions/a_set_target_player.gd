extends Action

class_name ASetTargetPlayer

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.seen_players.size() > 0:
		# print("Sees creatures!")
		for player in blackboard.seen_players:
			
			if player:

				blackboard.current_target = player
				return
	else:
		print("ERROR: NO PLAYER FOUND")
		blackboard.current_target = null
