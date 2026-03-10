extends Quest

class_name Quest03

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Bittybush Fruit Dropping"
	description = "Hello, researcher!\nI'm a forager who just loves Bittybush fruit.\nBut, waiting for it to fall off is such a pain!\nI've heard there's a way to make them drop it, though...\n(TASK: Take three pictures of you - or something else - making Bittybush drop its fruit!)"
	reward_desc = "REWARD: A big smile"
	reward_thanks = "Thank you, researcher!\nI'll try poking the Bittybushes, since attacking them seems cruel.\nBy the way, I heard Bittybushes run away if they get too stressed,\nso be sure to give them a good petting soemtimes!"
	
	creature_type = "PlantCreature"
	state_types = {
		"Poke": 0,
		"Stunned": 0
	}
	pics_per_state = 3
	percent_needed = 0.5 # Only need 3/4 images

func check_requirements() -> bool:
	if GameState.found_states["PlantCreature"]["Idle"] == 0:
		return false
	if GameState.num_found_states < 12:
		return false
	return true

# TODO: Only update if Bittybush dropped a fruit! This means making a sprite!
func update_progress(creature: Creature, state_name: StringName) -> int:
	# Return fail if creature type of photo doesn't match quest
	if creature.get_type() != creature_type:
		return 0
	# Return fail if state type isn't in tracked state list
	if not state_types.has(state_name):
		return 0
	
	if creature.blackboard is BlackboardPlantCreature:
		if not creature.blackboard.dropped_food:
			return 0
	# Update state image count
	state_types[state_name] += 1
	
	# If all requirements complete, return total success
	if check_completion():
		return 2
		
	# Otherwise, return partial success
	return 1

func get_reward() -> void:
	pass # TODO: Figure out rewards!
