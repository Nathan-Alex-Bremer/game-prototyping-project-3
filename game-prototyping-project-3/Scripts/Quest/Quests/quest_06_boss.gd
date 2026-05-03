extends Quest

class_name Quest06

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Study the Legendary Beast!"
	description = "Hello,\n\nResearcher, I've detected a large, mysterious creature coming your way!\nI've only heard legends about it before... what did you do?\nFor now, be sure to capture every last one of its states\nbefore it gets bored and leaves! I've heard it's fickle and super hungry..."
	task_desc = "    - TASK: Take one picture of each of the legendary beast's states!"
	reward_desc = "    - REWARD: A very big smile"
	reward_thanks = "Incredible work!\nYou've done something amazing today. With this, we should get plenty of funding!\nWe'll celebrate when you get back, so for now, say your goodbyes to the creatures..."
	
	creature_type = "Boss"
	state_types = {
		"Idle": 0,
		"Wander": 0,
		"Eat": 0,
		"Chase": 0,
		"Attack Eat": 0,
		"Attack": 0,
		"Pet": 0,
		"Alerted": 0,
		"Play": 0,
		"Rest": 0
	}
	pics_per_state = 5
	percent_needed = 0.33 # Only need 3/4 images

func check_requirements() -> bool:
	if GameState.completed_quests < 5 and (GameState.debug_on == false): # All other quests must be complete
		return false
	if not GameState.horn_sounded: # Horn must be sounded
		return false
	return true

func get_reward() -> void:
	pass # TODO: Figure out rewards!
