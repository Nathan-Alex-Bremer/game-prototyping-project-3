extends MonsterState
class_name CreatureStatePet

var wait_time: float = 2

func enter():
	print("Pet!")
	owning_creature.change_feisty(-50, false)
	
	# Update wants to play
	if owning_creature.feisty > 10 and owning_creature.feisty < 60 and owning_creature.hunger > 25 and owning_creature.tired < 60:
		blackboard.wants_to_play = true
	else:
		blackboard.wants_to_play = false
	
	blackboard.aggressive = false
	
	wait_time = 2

# The reason this is here instead of just immediately transitioning to idle is:
# 1. to allow the player to capture a creature in the Eating state
# 2. to make sure creatures stop to eat even if they still want more food
func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1, true)
	owning_creature.change_feisty(_delta * 0.48, true)
	owning_creature.change_tired(_delta * 0.21, true)
	
	
	if blackboard.stunned:
		Transitioned.emit(self, "creaturestatestunned")
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
	blackboard.is_pet = false
