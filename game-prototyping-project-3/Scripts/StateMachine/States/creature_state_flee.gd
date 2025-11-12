extends MonsterState
class_name CreatureStateFlee

var move_direction: Vector2
var random_location: Vector2
var wander_time: float

func randomize_wander():
	random_location = Vector2(randf_range(0, GameState.screen_size.x), randf_range(0, GameState.screen_size.y))
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func enter():
	randomize_wander()
	
	blackboard.wants_to_play = false
	
	owning_creature.velocity = move_direction * owning_creature.move_speed * 1.2
	
func update(_delta):
	
	# Expend resources
	owning_creature.change_food(_delta * -1, true)
	owning_creature.change_feisty(_delta * -0.48, true)
	owning_creature.change_tired(_delta * 0.21, true)
	
	if blackboard.stunned:
		Transitioned.emit(self, "creaturestatestunned")
		return
		
	# Transitions
	# Handled SUPER awkwardly because I'm on a fat time crunch and don't have time
	# To figure out how to set up a flywheel
	# And my attempt to use object-oriented stuff led to recursion I couldn't easily sort out
	
	if wander_time <= 0:
		# If attacker is far enough away or no longer aggressive, return to idle
		# Otherwise, flee again
		if not blackboard.current_attacker:
			Transitioned.emit(self, "creaturestateidle")
			return
		
		if not blackboard.current_attacker.blackboard.aggressive:
			blackboard.current_attacker = null
			Transitioned.emit(self, "creaturestatewander")
			return
		
		var direction = blackboard.current_attacker.global_position - owning_creature.global_position
		if direction.length() > 150:
			blackboard.current_attacker = null
			Transitioned.emit(self, "creaturestateidle")
			return
		
		# If hungry, don't stop looking
		randomize_wander()
		owning_creature.velocity = move_direction * owning_creature.move_speed * 1.2
	
	wander_time -= _delta
