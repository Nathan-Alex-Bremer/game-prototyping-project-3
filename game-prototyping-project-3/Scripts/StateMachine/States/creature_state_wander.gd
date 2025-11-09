extends State
class_name CreatureStateWander

var move_direction: Vector2
var random_location: Vector2
var wander_time: float

func randomize_wander():
	random_location = Vector2(randf_range(0, GameState.screen_size.x), randf_range(0, GameState.screen_size.y))
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func enter():
	randomize_wander()
	
	# Update wants to play
	if owning_creature.feisty > 20 and owning_creature.feisty < 60 and owning_creature.hunger > 25 and owning_creature.tired < 60:
		blackboard.wants_to_play = true
	else:
		blackboard.wants_to_play = false
	
	owning_creature.velocity = move_direction * owning_creature.move_speed
	
func update(_delta):
	
	# Expend resources
	owning_creature.change_food(_delta * -1)
	owning_creature.change_feisty(_delta * 0.48)
	owning_creature.change_tired(_delta * 0.21)
		
	# Transitions
	# Handled SUPER awkwardly because I'm on a fat time crunch and don't have time
	# To figure out how to set up a flywheel
	# And my attempt to use object-oriented stuff led to recursion I couldn't easily sort out
	
	if blackboard.stunned:
		Transitioned.emit(self, "creaturestatestunned")
		return
	
	if blackboard.is_pet:
		print("Got pet!")
		Transitioned.emit(self, "creaturestatepet")
		return
		
	if blackboard.is_poked:
		print("Got poked!")
		Transitioned.emit(self, "creaturestatepoke")
		return
	
	if wander_time <= 0:
		# Transition to hunger
		
		if blackboard.wants_to_play:
			print("Wants to play!")
			if blackboard.seen_creatures.size() > 0:
				print("Sees creatures!")
				for other_creature in blackboard.seen_creatures:
					if other_creature.get_wants_to_play():
						print("Other creature wants to play!")
						blackboard.current_target = other_creature
						Transitioned.emit(self, "creaturestatemovetofriend")
						return
						
			
		if owning_creature.hunger >= 25 and owning_creature.feisty <= 60:
			Transitioned.emit(self, "creaturestateidle")
			return
		
		# If hungry, don't stop looking
		randomize_wander()
		owning_creature.velocity = move_direction * owning_creature.move_speed
	
	# If hungry, constantly check for nearby food
	if owning_creature.hunger < 25:
		if blackboard:
			if blackboard.seen_food.size() > 0:
				print("Hungry!")
				blackboard.current_target = blackboard.seen_food[0]
				Transitioned.emit(self, "creaturestatemovetofood")
				return
	
	if owning_creature.feisty > 60:
		if blackboard:
			if blackboard.seen_creatures.size() > 0:
				print("Sees creatures!")
				for other_creature in blackboard.seen_creatures:
					blackboard.current_target = other_creature
					Transitioned.emit(self, "creaturestatechase")
					return
	
	# elif instead of if, to prevent constant switching between wander and rest
	if owning_creature.tired >= 75:
		print("Tired!")
		Transitioned.emit(self, "creaturestaterest")
		return
	
	wander_time -= _delta

func physics_update(_delta):
	if owning_creature:
		pass
		## Reverse x-value movement if going out of bounds
		#if owning_creature.position.x >= GameState.screen_size.x or owning_creature.position.x <= 0:
			#move_direction.x *= -1
		## Reverse y-value movement if going out of bounds
		#if owning_creature.position.y >= GameState.screen_size.y or owning_creature.position.y <= 0:
			#move_direction.y *= -1
		
		
