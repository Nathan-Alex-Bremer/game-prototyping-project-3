extends Quest

class_name Quest01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Scaring Rodink!"
	description = "Hello,\n\nI'm a local farmer dealing with a Rodink infestation.\nThey're eating my crops, but I can't bring myself to hurt the little things.\nCould you tell me how to scare them off, instead?"
	task_desc = "    - TASK: Take 3 pictures of Rodinks in the 'Flee' state!"
	reward_desc = "    - REWARD: A big smile"
	reward_thanks = "Thank you, researcher!\nI'm looking into a pet Charnine to help scare them off.\nI hear more Rodinks will appear if there's a lot of food, by the way, so watch out!"
	
	creature_type = "Creature"
	state_types = {
		"Flee": 0
	}
	pics_per_state = 3

func check_requirements() -> bool:
	if GameState.found_states["Creature"]["Idle"] == 0:
		return false
	#if GameState.num_found_states < 5:
		#return false
	return true

func get_reward() -> void:
	pass # TODO: Figure out rewards!
