extends State
class_name CreatureStateRest

func enter():
	blackboard.wants_to_play = false

func update(_delta):
	# Change resources 
	owning_creature.change_food(_delta * -0.5)
	owning_creature.change_feisty(_delta * 0.24)
	owning_creature.change_tired(_delta * -5)
	owning_creature.change_hit_points(_delta)
	
	# Transitions
	
	if blackboard.stunned:
		Transitioned.emit(self, "creaturestatestunned")
		return
	
	if owning_creature.hunger <= 25:
		print("Hungry!")
		Transitioned.emit(self, "creaturestatemovetofood")
		return
	
	if owning_creature.tired <= 25:
		Transitioned.emit(self, "creaturestatewander")
		return
		
	pass

func physics_update(_delta):
	if owning_creature:
		owning_creature.velocity = Vector2.ZERO # Ew, should not need to be done
