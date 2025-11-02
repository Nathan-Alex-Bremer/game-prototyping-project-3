extends Action

# Enter function, randomizes move direction
func act(blackboard: Blackboard):
	if blackboard.creature:
		blackboard.creature.velocity = blackboard.move_direction * blackboard.move_speed
		blackboard.creature.move_and_slide()
