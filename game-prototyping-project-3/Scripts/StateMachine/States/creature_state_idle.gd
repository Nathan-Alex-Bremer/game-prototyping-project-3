extends State
class_name CreatureStateIdle

var wait_time: float

func randomize_wait():
	wait_time = randf_range(1, 3)

func enter():
	randomize_wait()
	
	# Update wants to play
	if owning_creature.feisty > 20 and owning_creature.feisty < 60 and owning_creature.hunger > 25 and owning_creature.tired < 60:
		blackboard.wants_to_play = true
	else:
		blackboard.wants_to_play = false

func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -0.75)
	owning_creature.change_feisty(_delta * 0.36)
	owning_creature.change_tired(_delta * 0.15)
	
	
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
	
	if wait_time <= 0:
		print("Waited!")
		Transitioned.emit(self, "creaturestatewander")
		return
		# randomize_wait()
	
	if owning_creature.hunger <= 25:
		print("Hungry, wandering!")
		Transitioned.emit(self, "creaturestatewander")
		return
	
	if owning_creature.tired >= 75:
		print("Tired!")
		Transitioned.emit(self, "creaturestaterest")
		return
		
	wait_time -= _delta

func physics_update(_delta):
	if owning_creature:
		owning_creature.velocity = Vector2.ZERO # Ew, should not need to be done
