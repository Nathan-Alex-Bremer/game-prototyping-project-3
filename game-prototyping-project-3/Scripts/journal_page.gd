extends Node2D

class_name JournalPage

var found_states_creature: float = 0
var progress: float = 0
@export var total_states: float = 0

func on_state_found(found_state: StringName, times_found: int) -> void:
	pass

#func update_progress() -> void:
	## Entirely because it'd get annoying otherwise
	#$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
	
func toggle_opened() -> void:
	print("Page toggle opened")
	self.visible = (not self.visible)
	
func clear_update_labels() -> void:
	pass
	
func toggle_star() -> void:
	print("Toggling star!")
	$CompletionStar.visible = true
