extends State
class_name CreatureStateIdle

@export var owning_creature: Creature

var wait_time: float

func randomize_wait():
	wait_time = randf_range(1, 3)

func enter():
	randomize_wait()

func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1)
	owning_creature.change_feisty(_delta * 0.48)
	owning_creature.change_tired(_delta * 0.21)
	
	
		
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
