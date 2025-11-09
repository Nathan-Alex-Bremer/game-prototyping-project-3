extends State
class_name CreatureStatePlay

var wait_time: float

func enter():
	wait_time = 2
	owning_creature.change_feisty(-30)

func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1)
	owning_creature.change_feisty(_delta * 0.48)
	owning_creature.change_tired(_delta * 0.21)
	
	
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
		
	wait_time -= _delta

func physics_update(_delta):
	if owning_creature:
		owning_creature.velocity = Vector2.ZERO # Ew, should not need to be done

func exit():
	blackboard.wants_to_play = false
