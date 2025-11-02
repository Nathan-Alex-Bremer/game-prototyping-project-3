extends Condition

@export var time_to_wait: float

func evaluate(blackboard: Blackboard):
	return (blackboard.state_time_elapsed >= time_to_wait)
