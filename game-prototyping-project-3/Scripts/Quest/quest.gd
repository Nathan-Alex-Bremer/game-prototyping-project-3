extends Node

class_name Quest

# Variables
var status: int = QuestStates.NOT_STARTED
@export var quest_name: StringName = ""
@export var description: String = ""
@export var task_desc: StringName = ""
@export var reward_desc: StringName = ""
@export var reward_thanks: StringName = ""

@export var creature_type: StringName
@export var state_types: Dictionary[StringName, int]
@export var pics_per_state: int
@export var percent_needed: float = 1

var newly_available: int = 0

enum QuestStates {
	NOT_STARTED,
	IN_PROGRESS,
	FINISHED
}
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Lays out requirements
func check_requirements() -> bool:
	return true
# Implement in individual

func check_available() -> bool:
	if status != QuestStates.NOT_STARTED:
		return false
	if not check_requirements():
		return false
	
	if newly_available == 0:
		newly_available = 1
	return true

# Implement in individual
func get_reward() -> void:
	return

func start_quest() -> bool:
	if status == QuestStates.NOT_STARTED:
		status = QuestStates.IN_PROGRESS
		return true
	return false

func pause_quest() -> bool:
	if status == QuestStates.IN_PROGRESS:
		status = QuestStates.NOT_STARTED
		return true
	return false
	
func check_completion() -> int:
	var progress_val = 0
	var total_val = 0
	for state in state_types:
		progress_val += min(state_types[state], pics_per_state) # Count up number of pictures taken for each state (up to required amount)
		total_val += pics_per_state # Count up total number of pictures required
	
	if progress_val >= total_val * percent_needed:
		return true
	return false

func calculate_progress() -> StringName:
	var final_string = ""
	var progress_val = 0
	var total_val = 0
	for state in state_types:
		progress_val += min(state_types[state], pics_per_state) # Count up number of pictures taken for each state (up to required amount)
		total_val += pics_per_state # Count up total number of pictures required
	final_string = str(progress_val) + "/" + str(int(total_val * percent_needed))
	
	return final_string

func update_progress(creature: Creature, state_name: StringName) -> int:
	# Return fail if creature type of photo doesn't match quest
	if creature.get_type() != creature_type:
		return 0
	# Return fail if state type isn't in tracked state list
	if not state_types.has(state_name):
		return 0
	# Update state image count
	state_types[state_name] += 1
	
	# If all requirements complete, return total success
	if check_completion():
		return 2
		
	# Otherwise, return partial success
	return 1

func finish_quest() -> bool:
	if status == QuestStates.IN_PROGRESS:
		status = QuestStates.FINISHED
		return true
	return false
