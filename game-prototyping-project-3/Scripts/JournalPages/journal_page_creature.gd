extends JournalPage

class_name JournalPageCreature

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- WANDER: Tends to wander aimlessly."
				$StateWander.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				$StateWander/UpdateLabel.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateWander.text = "- WANDER: Tends to wander aimlessly. Rarely, if ever, runs."
				$StateWander/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateWander.text = "- WANDER: Will wander aimlessly, often looking for food or friends."
				$StateWander/UpdateLabel.visible = true
				$StateWander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- IDLE: Pale in color."
				$StateIdle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				$StateIdle/UpdateLabel.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIdle.text = "- IDLE: Pale in color, but can come in many hues."
				$StateIdle/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateIdle.text = "- IDLE: Pale in color, but can come in many hues. Large, emotive ears."
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
				$StateEat.text = "- EAT: Can eat their entire body weight in fruit a single day."
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
				$StateRest.text = "- REST: Their highly efficient bodies can restore plenty of energy from just a short nap."
				$StateRest/UpdateLabel.visible = true
				$StateRest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- PET: Their fur is soft and velvety."
				$StatePet/UpdateLabel.visible = true
				$StatePet.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- PET: Being pet seems to calm them down. They enjoy it a lot."
				$StatePet/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePet.text = "- PET: Being pet calms them down and also seems to make them tired."
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
				$StatePoke.text = "- ANNOY: Struggles to sit still when agitated."
				$StatePoke/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- ANNOY: Even a couple pokes will whip them into a frenzy, causing them to look for fights."
				$StatePoke/UpdateLabel.visible = true
				$StatePoke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- PLAY: Will sometimes jump around and make squeaking noises with others of their species."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- PLAY: Jumping around with others seems to lower their stress."
				$StatePlay/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- PLAY: Will play with others of their species by jumping around, reducing stress."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Chase":
			if times_found == 1:
				$StateChase.text = "- CHASE: Runs around when agitated."
				$StateChase/UpdateLabel.visible = true
				$StateChase.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateChase.text = "- CHASE: When agitated, will often seek out and attack others of their kind."
				$StateChase/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateChase.text = "- CHASE: When agitated, will chase down others of their kind until worn out."
				$StateChase/UpdateLabel.visible = true
				$StateChase.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- ATTACK: Fights primarily by biting."
				$StateAttack/UpdateLabel.visible = true
				$StateAttack.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- ATTACK: Fights using their sharp front teeth to defend themselves or pick fights."
				$StateAttack/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- ATTACK: With their sharp front teeth, they can even scare off predators."
				$StateAttack/UpdateLabel.visible = true
				$StateAttack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- FLEE: Runs around aimlessly when near predators."
				$StateFlee/UpdateLabel.visible = true
				$StateFlee.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- FLEE: When attacked or near a predator, runs aimlessly until safe."
				$StateFlee/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- FLEE: Will panic and run aimlessly when threatened, unless they're particularly feisty."
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
	
