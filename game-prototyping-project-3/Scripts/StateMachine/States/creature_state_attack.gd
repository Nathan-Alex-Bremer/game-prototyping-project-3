extends MonsterState
class_name CreatureStateAttack

var wait_time: float

func randomize_wait():
	wait_time = randf_range(1, 3)

func enter():
	var found_bodies = %EatRadius.get_overlapping_bodies()
	
	# Attack nearby creature
	# Lowers target HP, adds flag to target blackboard to make them run, sets self as target's attacker, sets self as attacking
	# Afterwards, return to chasing if feisty is still too high
	for body in found_bodies:
		if body.is_in_group("creature") and body != owning_creature:
			
			body.deal_damage(owning_creature, 10)
			blackboard.aggressive = true
			owning_creature.change_feisty(-10, false)
			wait_time = 3
			break
	

# The reason this is here instead of just immediately transitioning to idle is:
# 1. to allow the player to capture a creature in the Eating state
# 2. to make sure creatures stop to eat even if they still want more food
func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1, true)
	owning_creature.change_tired(_delta * 0.21, true)
	
	if blackboard.stunned:
		Transitioned.emit(self, "creaturestatestunned")
		return
	
	if wait_time <= 0:
		print("Attack complete!")
		
		if owning_creature.feisty < 20:
			blackboard.current_target = null
			Transitioned.emit(self, "creaturestateidle")
			return
			
		Transitioned.emit(self, "creaturestatechase")
		return
		# randomize_wait()
	
	wait_time -= _delta
