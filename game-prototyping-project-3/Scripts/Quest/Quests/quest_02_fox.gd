extends Quest

class_name Quest02

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	quest_name = "Charnine Fire"
	description = "Hello,\n\nI'm a blacksmith who's curious about using a Charnine for my forge,\nbut I'm just not sure if their fire gets hot enough.\nCould you take some photos for me so I can get a better look?"
	task_desc = "    - TASK: Capture three different states where Charnine\n      breathes fire or flares its tail!"
	reward_desc = "    - REWARD: A big smile"
	reward_thanks = "Thank you, researcher!\n\nIt doesn't look like the fire's quite hot enough, but oh well.\nI'd imagine they'd burn down any nearby foliage, though!"
	
	creature_type = "Predator"
	state_types = {
		"Annoyed": 0,
		"Intimidate": 0,
		"Attack": 0,
		"Attack Eat": 0,
		"Yawn": 0
	}
	pics_per_state = 1
	percent_needed = 0.6 # Only need 3/5 images

func check_requirements() -> bool:
	if GameState.found_states["Predator"]["Idle"] == 0:
		return false
	#if GameState.num_found_states < 10:
		#return false
	return true

func get_reward() -> void:
	pass # TODO: Figure out rewards!
