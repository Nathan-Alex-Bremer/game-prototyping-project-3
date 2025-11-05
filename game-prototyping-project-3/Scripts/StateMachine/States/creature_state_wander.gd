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
	owning_creature.change_tired(_delta * 0.22)
		
	# Transitions
	# Handled SUPER awkwardly because I'm on a fat time crunch and don't have time
	# To figure out how to set up a flywheel
	# And my attempt to use object-oriented stuff led to a recursive mess
	if wander_time <= 0:
		# Transition
		Transitioned.emit(self, "creaturestateidle")
		return
		# randomize_wander()
	
	if owning_creature.hunger <= 25:
		print("Hungry!")
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
