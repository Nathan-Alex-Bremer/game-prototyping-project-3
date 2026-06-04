extends Quest

class_name Quest08

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Pollinsect Pollen"
	description = "Greetings,\n\nI'm a florist looking for new types of flowers.\nI hear Pollinsect causes flowers to grow, but\nI'm not sure where it gets the pollen from! Could you investigate?"
	task_desc = "    - TASK: Take six pictures of Pollinsect gathering or scattering pollen!"
	reward_desc = "    - REWARD: A big smile"
	reward_thanks = "Thank you, researcher!\n\nThose are some lovely flowers. I'll have to find\na Bittybush to raise! I hear Frountains\nlove the flowers they grow together."
	
	creature_type = "Moth"
	state_types = {
		"Pollinate": 0,
		"Spread Pollen": 0
	}
	pics_per_state = 6
	percent_needed = 0.5 # Only need 3/4 images

func check_requirements() -> bool:
	if GameState.found_states["Moth"]["Idle"] == 0:
		print("Moth quest locked")
		return false
	#if GameState.num_found_states < 28:
		#return false
	print("Moth quest unlocked")
	return true

# TODO: Only update if Bittybush dropped a fruit! This means making a sprite!

func get_reward() -> void:
	pass # TODO: Figure out rewards!
