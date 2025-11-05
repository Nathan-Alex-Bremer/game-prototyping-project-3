extends State
class_name CreatureStateWander

@export var owning_creature: Creature

var move_direction: Vector2
var wander_time: float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

func enter():
	randomize_wander()
	
func update(_delta):
	
	# Expend resources
	owning_creature.change_food(_delta * -1)
	owning_creature.change_feisty(_delta * 0.48)
	owning_creature.change_tired(_delta * 0.21)
		
	# Transitions
	# Handled SUPER awkwardly because I'm on a fat time crunch and don't have time
	# To figure out how to set up a flywheel
	# And my attempt to use object-oriented stuff led to recursion I couldn't easily sort out
	
	
	
	if wander_time <= 0:
		# Transition
		if owning_creature.hunger >= 25:
			Transitioned.emit(self, "creaturestateidle")
			return
		
		# If hungry, don't stop looking
		randomize_wander()
	
	# If hungry, constantly check for nearby food
	if owning_creature.hunger <= 25:
		var nearby_entities = %DetectRadius.get_overlapping_areas()
		
		for entity in nearby_entities:
			if entity.is_in_group("food"):
				print("Hungry!")
				
				# Update blackboard reference to current target
				if blackboard:
					blackboard.current_target = entity
				
				Transitioned.emit(self, "creaturestatemovetofood")
				return
		
	
	if owning_creature.tired >= 75:
		print("Tired!")
		Transitioned.emit(self, "creaturestaterest")
		return
	
	wander_time -= _delta

func physics_update(_delta):
	if owning_creature:
		# Reverse x-value movement if going out of bounds
		if owning_creature.position.x >= GameState.screen_size.x or owning_creature.position.x <= 0:
			move_direction.x *= -1
		# Reverse y-value movement if going out of bounds
		if owning_creature.position.y >= GameState.screen_size.y or owning_creature.position.y <= 0:
			move_direction.y *= -1
		
		owning_creature.velocity = move_direction * owning_creature.move_speed
