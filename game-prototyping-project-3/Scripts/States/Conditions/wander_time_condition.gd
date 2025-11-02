extends Condition

func evaluate(blackboard: Blackboard):
	return (blackboard.state_time_elapsed >= blackboard.wander_time)
