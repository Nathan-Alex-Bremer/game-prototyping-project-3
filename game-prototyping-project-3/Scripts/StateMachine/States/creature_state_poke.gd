extends State
class_name CreatureStatePoke

var wait_time: float = 2

func enter():
	print("Poke!")
	owning_creature.change_feisty(50)
	
	wait_time = 2

# The reason this is here instead of just immediately transitioning to idle is:
# 1. to allow the player to capture a creature in the Eating state
# 2. to make sure creatures stop to eat even if they still want more food
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
	
	wait_time -= _delta

func physics_update(_delta):
	if owning_creature:
		owning_creature.velocity = Vector2.ZERO # Ew, should not need to be done

func exit():
	blackboard.is_poked = false
