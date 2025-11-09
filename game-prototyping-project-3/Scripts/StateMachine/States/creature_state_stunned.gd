extends State
class_name CreatureStateStunned

var wait_time: float = 2

func enter():
	print("Attacked!")
	owning_creature.change_feisty(5) #TODO: Change
	
	wait_time = 2
	blackboard.stunned = false

# The reason this is here instead of just immediately transitioning to idle is:
# 1. to allow the player to capture a creature in the Eating state
# 2. to make sure creatures stop to eat even if they still want more food
func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1)
	owning_creature.change_feisty(_delta * 0.48)
	owning_creature.change_tired(_delta * 0.21)
	
	
	# After waiting out the stun period, immediately go to flee if not feisty enough or low HP
	# Or to chase on attacker if feisty enough
	if wait_time <= 0:
		if owning_creature.feisty > 40 and owning_creature.hit_points > 50:
			blackboard.current_target = blackboard.current_attacker
			Transitioned.emit(self, "creaturestatechase")
			return
			
		print("Waited!")
		Transitioned.emit(self, "creaturestateflee")
		return
		# randomize_wait()
	
	wait_time -= _delta

func physics_update(_delta):
	if owning_creature:
		owning_creature.velocity = Vector2.ZERO # Ew, should not need to be done
