extends Action

class_name AMoveRandomDirection

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	var random_location = Vector2(randf_range(0, GameState.screen_size.x), randf_range(0, GameState.screen_size.y))
	var move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	var wander_time = randf_range(1, 3)
	
	owning_creature.velocity = move_direction * owning_creature.move_speed
