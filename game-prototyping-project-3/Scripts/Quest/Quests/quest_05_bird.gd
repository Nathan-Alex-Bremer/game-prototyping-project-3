extends Quest

class_name Quest05

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Distract Sonicoo!"
	description = "Hello, researcher!\n\nI love Sonicoo very much! But, they always run away from me!\nI hear there are ways to distract them so they won't run away...\nCould you take some photos showing me how to do it?"
	task_desc = "    - TASK: Take five pictures of ways to distract or placate Sonicoo!"
	reward_desc = "    - REWARD: A big smile"
	reward_thanks = "Thank you, researcher!\nI'll be sure to gather lots of fruits for Sonicoo.\nI tried poking them, but they always just ran away when I did that..."
	
	creature_type = "Bird"
	state_types = {
		"Eat": 0,
		"Pet": 0,
		"Play": 0
	}
	pics_per_state = 5
	percent_needed = 0.33 # Only need 3/4 images

func check_requirements() -> bool:
	if GameState.found_states["Bird"]["Idle"] == 0:
		return false
	#if GameState.num_found_states < 35:
		#return false
	return true

# TODO: Only update if Bittybush dropped a fruit! This means making a sprite!

func get_reward() -> void:
	pass # TODO: Figure out rewards!
