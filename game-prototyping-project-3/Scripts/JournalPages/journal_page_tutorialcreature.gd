extends JournalPage

class_name JournalPageTutorialCreature

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
			
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- IDLE: Lumpy and pink in color."
				$StateIdle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				$StateIdle/UpdateLabel.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIdle.text = "- IDLE: It's a plush toy. Lumpy and pink in color."
				$StateIdle/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateIdle.text = "- IDLE: It's a soft, pink plush. The professor made it herself."
				$StateIdle/UpdateLabel.visible = true
				$StateIdle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
	
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(found_states_creature)
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	print("Progress:" + str(progress))
	print("Total States: " + str(total_states))
	$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
	
	if progress == 1:
		$HiddenSprite.visible = false
		
	if progress == 5:
		$Instructions.text = "Use interaction modes (Q) to find new states!"
		
	if progress == 10:
		$Instructions.text = "Take lots of photos of a state for more info!"
		
	if progress == 15:
		$Instructions.text = "Journal entries turn green when complete!"
		
	if progress == 30:
		$Instructions.text = "Great job!"

func clear_update_labels() -> void:
	$StateIdle/UpdateLabel.visible = false
	
