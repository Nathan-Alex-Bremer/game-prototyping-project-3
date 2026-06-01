extends Quest

class_name Quest07

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Call It A Day"
	description = "Hello,\n\nIncredible work, researcher! I knew I could count on you! Whenever you're ready, come on back and take a well-earned rest."
	task_desc = "    - TASK: Take it easy!"
	reward_desc = "    - NOTE: Accepting this Quest will end the game."
	reward_thanks = "Incredible work!\n\nYou've done something amazing today. With this, we should get plenty of funding!\nWe'll celebrate when you get back, so for now, say your goodbyes to the creatures..."
	
	creature_type = "Creature"
	state_types = {
		"Idle": 0
	}
	pics_per_state = 5
	percent_needed = 1.0 # Only need 3/4 images

func check_requirements() -> bool:
	if GameState.completed_quests < 6 and (GameState.debug_on == false): # All other quests must be complete
		return false
	return true

func get_reward() -> void:
	pass # TODO: Figure out rewards!
