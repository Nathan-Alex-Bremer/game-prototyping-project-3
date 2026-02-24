extends JournalPage

class_name JournalPageBird

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- WANDER: Constantly flies about."
				$StateWander/UpdateLabel.visible = true
				$StateWander.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateWander.text = "- WANDER: Constantly flying. Will flee from humans."
				$StateWander/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateWander.text = "- WANDER: Constantly flying. Will flee from humans if not totally relaxed."
				$StateWander/UpdateLabel.visible = true
				$StateWander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- IDLE: Blue in color."
				$StateIdle/UpdateLabel.visible = true
				$StateIdle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIdle.text = "- IDLE: Blue in color, with some sort of marking on its chest."
				$StateIdle/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateIdle.text = "- IDLE: Blue in color. The organs in its chest increase flying speed."
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
				$StateEat.text = "- EAT: Eats primarily fruit. Their favorite is large, red, juicy fruits."
				$StateEat/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateEat.text = "- EAT: Can be temporarily distracted with the fruit it loves so much."
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
				$StateRest.text = "- REST: To avoid danger, sleeps only in short bursts."
				$StateRest/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateRest.text = "- REST: Only rarely sleeps, to avoid being caught off-guard."
				$StateRest/UpdateLabel.visible = true
				$StateRest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- PET: Has soft feathers."
				$StatePet/UpdateLabel.visible = true
				$StatePet.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- PET: Being pet seems to calm them down and make them more amicable."
				$StatePet/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePet.text = "- PET: Being pet calms them down and makes them warm up to people."
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
				$StatePoke.text = "- ANNOY: Will fly away when poked."
				$StatePoke/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- ANNOY: Will fly away when poked, but usually won't become aggressive."
				$StatePoke/UpdateLabel.visible = true
				$StatePoke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- PLAY: Will sometimes stop to bob their head and sing."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- PLAY: Plays by singing and bobbing their head."
				$StatePlay/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- PLAY: Plays by singing and bobbing their head, reducing stress."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Chase":
			if times_found == 1:
				$StateChase.text = "- CHASE: Flies around when agitated."
				$StateChase/UpdateLabel.visible = true
				$StateChase.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateChase.text = "- CHASE: When agitated, will often seek out and attack anything in sight."
				$StateChase/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateChase.text = "- CHASE: When agitated, will chase down others and strike until worn out."
				$StateChase/UpdateLabel.visible = true
				$StateChase.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- ATTACK: Fights primarily with their claws."
				$StateAttack/UpdateLabel.visible = true
				$StateAttack.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- ATTACK: Fights using their sharp talons from mid-air."
				$StateAttack/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- ATTACK: Using their sharp talons, they can ward off foes and predators."
				$StateAttack/UpdateLabel.visible = true
				$StateAttack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- FLEE: Will flee when attacked."
				$StateFlee/UpdateLabel.visible = true
				$StateFlee.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- FLEE: When attacked, will try to escape the assailant."
				$StateFlee/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- FLEE: Will flee when they feel unsafe, such as when attacked."
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
		$Instructions.text = "Use interaction modes to find new states!"
		
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
