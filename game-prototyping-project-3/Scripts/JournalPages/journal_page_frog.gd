extends JournalPage

class_name JournalPageFrog

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- WANDER: Hops around in a carefree manner."
				$StateWander.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				$StateWander/UpdateLabel.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateWander.text = "- WANDER: Hops along in a straight line when not bothered."
				$StateWander/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateWander.text = "- WANDER: Hops around, generally taking breaks, but can turn on a dime."
				$StateWander/UpdateLabel.visible = true
				$StateWander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- IDLE: Blue in color."
				$StateIdle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				$StateIdle/UpdateLabel.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIdle.text = "- IDLE: Blue in color, with a hole in their back to spray out water."
				$StateIdle/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateIdle.text = "- IDLE: Blue in color, with rubbery skin that can puff up or spray water."
				$StateIdle/UpdateLabel.visible = true
				$StateIdle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Eat":
			if times_found == 1:
				$StateEat.text = "- EAT: Enjoys eating fruit."
				$StateEat/UpdateLabel.visible = true
				$StateEat.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateEat.text = "- EAT: Use their long tongues to grab fruit from afar."
				$StateEat/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateEat.text = "- EAT: Their tongue can stretch up to their entire body length to grab food!"
				$StateEat/UpdateLabel.visible = true
				$StateEat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- REST: Takes short naps every so often to restore energy."
				$StateRest/UpdateLabel.visible = true
				$StateRest.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateRest.text = "- REST: Sleeps for a long time to recover stamina."
				$StateRest/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateRest.text = "- REST: Rarely sleeps, but takes long naps when they do get worn out."
				$StateRest/UpdateLabel.visible = true
				$StateRest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- PET: Their skin is slippery."
				$StatePet/UpdateLabel.visible = true
				$StatePet.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- PET: Their skin is covered in slime which keeps them from drying out."
				$StatePet/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePet.text = "- PET: Their slimy skin prevents drying out, but they can't stay in the sun for long."
				$StatePet/UpdateLabel.visible = true
				$StatePet.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- ANNOY: Becomes agitated when poked."
				$StatePoke/UpdateLabel.visible = true
				$StatePoke.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- ANNOY: Will puff out their cheeks when poked."
				$StatePoke/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- ANNOY: When annoyed, will puff out their cheeks and spray water to intimidate foes."
				$StatePoke/UpdateLabel.visible = true
				$StatePoke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- PLAY: Enjoys spraying water to relieve stress."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- PLAY: Enjoys playing with other creatures by spraying a fountain of water.."
				$StatePlay/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- PLAY: Will play with many types of creatures by hopping about and spraying water."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Chase":
			if times_found == 1:
				$StateChase.text = "- CHASE: Will pursue other creatures when agitated."
				$StateChase/UpdateLabel.visible = true
				$StateChase.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateChase.text = "- CHASE: When agitated, will puff up and hop after a target."
				$StateChase/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateChase.text = "- CHASE: Enjoys fighting to relieve stress, hopping toward any target."
				$StateChase/UpdateLabel.visible = true
				$StateChase.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- ATTACK: Uses their long tongue to fight."
				$StateAttack/UpdateLabel.visible = true
				$StateAttack.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- ATTACK: Their tongue is their primary weapon, giving them high range."
				$StateAttack/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- ATTACK: Attacks with their whiplike tongue, which can strike instantly."
				$StateAttack/UpdateLabel.visible = true
				$StateAttack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- FLEE: Runs around aimlessly when attacked."
				$StateFlee/UpdateLabel.visible = true
				$StateFlee.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- FLEE: Will flee attackers, as well as Sonicoo, for some reason."
				$StateFlee/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- FLEE: Will hop about aimlessly to flee attackers or Sonicoo."
				$StateFlee/UpdateLabel.visible = true
				$StateFlee.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
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
	$StateWander/UpdateLabel.visible = false
	$StateIdle/UpdateLabel.visible = false
	$StateEat/UpdateLabel.visible = false
	$StateRest/UpdateLabel.visible = false
	$StatePet/UpdateLabel.visible = false
	$StatePoke/UpdateLabel.visible = false
	$StatePlay/UpdateLabel.visible = false
	$StateChase/UpdateLabel.visible = false
	$StateAttack/UpdateLabel.visible = false
	$StateFlee/UpdateLabel.visible = false
	
