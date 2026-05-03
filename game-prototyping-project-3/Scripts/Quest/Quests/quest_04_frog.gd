extends Quest

class_name Quest04

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Frountain Tongues"
	description = "Greetings,\n\nI am a fashion designer, and I want to make a scarf inspired by a Frountain tongue.\nBut, it pains me to say, I can't bring myself to touch the things.\nCould you take some photos for me to use as reference?"
	task_desc = "    - TASK: Take ten pictures of Frountain sticking out its tongue!"
	reward_desc = "    - REWARD: A big smile"
	reward_thanks = "Thank you, researcher!\nMy scarf is coming along nicely. I'm thinking of using\nRodink fur, if I can get it ethically sourced - they're so soft,\nand they just fall asleep in your arms when you pet them..."
	
	creature_type = "Frog"
	state_types = {
		"Eat": 0,
		"Attack": 0
	}
	pics_per_state = 10
	percent_needed = 0.5 # Only need 3/4 images

func check_requirements() -> bool:
	if GameState.found_states["Frog"]["Idle"] == 0:
		return false
	#if GameState.num_found_states < 28:
		#return false
	return true

# TODO: Only update if Bittybush dropped a fruit! This means making a sprite!

func get_reward() -> void:
	pass # TODO: Figure out rewards!
