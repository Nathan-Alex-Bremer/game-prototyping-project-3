extends State
class_name CreatureStateEat

@export var owning_creature: Creature

var wait_time: float

func randomize_wait():
	wait_time = randf_range(1, 3)

func enter():
	var found_areas = %EatRadius.get_overlapping_areas()
	
	for area in found_areas:
		if area.is_in_group("food"):
			area.consume(owning_creature)
			blackboard.current_target = null
			randomize_wait()
			break

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
