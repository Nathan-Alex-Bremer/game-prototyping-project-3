extends Action

func act(blackboard: Blackboard):
	print("Entered Idle Enter Action!")
	blackboard.creature.velocity = Vector2.ZERO
