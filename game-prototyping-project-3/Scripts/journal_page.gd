extends Node2D

class_name JournalPage

var found_states_creature: int = 0
var progress: int = 0
@export var total_states: int = 0

func on_state_found(found_state: StringName, times_found: int) -> void:
	pass

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
	
func toggle_opened() -> void:
	print("Page toggle opened")
	self.visible = (not self.visible)
	
