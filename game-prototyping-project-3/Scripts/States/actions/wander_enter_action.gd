extends Action

# Enter function, randomizes move direction
func act(blackboard: Blackboard):
	blackboard.move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	blackboard.wander_time = randf_range(1, 3)
	print("Entered Wander Enter Action!")
