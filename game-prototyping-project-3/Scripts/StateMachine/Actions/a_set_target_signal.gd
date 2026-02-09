extends Action

class_name ASetTargetSignal

func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	if blackboard.signal_sender:
		blackboard.current_target = blackboard.signal_sender
	else:
		print("ERROR: No signal sender")
		blackboard.current_target = null
