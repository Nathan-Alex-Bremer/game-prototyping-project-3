extends JournalPage

class_name JournalPageCreature

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- WANDER: Tends to wander aimlessly."
				$StateWander.modulate = Color(0.0, 0.0, 0.0, 1.0)
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateWander.text = "- WANDER: Tends to wander aimlessly. Rarely, if ever, runs."
				progress += 1
			if times_found == 30:
				$StateWander.text = "- WANDER: Will wander aimlessly, often looking for food or friends."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- IDLE: Pale in color."
				$StateIdle.modulate = Color(0.0, 0.0, 0.0, 1.0)
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateIdle.text = "- IDLE: Pale in color, but can come in many hues."
				progress += 1
			if times_found == 30:
				$StateIdle.text = "- IDLE: Pale in color, but can come in many hues. Large, emotive ears."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Eat":
			if times_found == 1:
				$StateEat.text = "- EAT: Enjoys eating fruit."
				$StateEat.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateEat.text = "- EAT: Eats primarily fruit. Their favorite is large, red, juicy fruits."
				progress += 1
			if times_found == 10:
				$StateEat.text = "- EAT: Can eat their entire body weight in fruit a single day."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- REST: Takes short naps every so often to restore energy."
				$StateRest.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateRest.text = "- REST: To avoid danger, sleeps only in short bursts."
				progress += 1
			if times_found == 10:
				$StateRest.text = "- REST: Their highly efficient bodies can restore plenty of energy from just a short nap."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- PET: Their fur is soft and velvety."
				$StatePet.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- PET: Being pet seems to calm them down. They enjoy it a lot."
				progress += 1
			if times_found == 10:
				$StatePet.text = "- PET: Being pet calms them down and also seems to make them tired."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- ANNOY: Becomes agitated when poked."
				$StatePoke.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- ANNOY: Struggles to sit still when agitated."
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- ANNOY: Even a couple pokes will whip them into a frenzy, causing them to look for fights."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- PLAY: Will sometimes jump around and make squeaking noises with others of their species."
				$StatePlay.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- PLAY: Jumping around with others seems to lower their stress."
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- PLAY: Will play with others of their species by jumping around, reducing stress."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Chase":
			if times_found == 1:
				$StateChase.text = "- CHASE: Runs around when agitated."
				$StateChase.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateChase.text = "- CHASE: When agitated, will often seek out and attack others of their kind."
				progress += 1
			if times_found == 10:
				$StateChase.text = "- CHASE: When agitated, will chase down others of their kind until worn out."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- ATTACK: Fights primarily by biting."
				$StateAttack.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- ATTACK: Fights using their sharp front teeth to defend themselves or pick fights."
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- ATTACK: With their sharp front teeth, they can even scare off predators."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- FLEE: Runs around aimlessly when near predators."
				$StateFlee.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- FLEE: When attacked or near a predator, runs aimlessly until safe."
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- FLEE: Will panic and run aimlessly when threatened, unless they're particularly feisty."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
	
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(found_states_creature)
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	print("Progress:" + str(progress))
	print("Total States: " + str(total_states))
	$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
	
	if progress == 5:
		$Instructions.text = "Use interaction modes to find new states!"
		
	if progress == 10:
		$Instructions.text = "Take lots of photos of a state for more info!"
		
	if progress == 15:
		$Instructions.text = "Journal entries turn green when complete!"
		
	if progress == 30:
		$Instructions.text = "Great job!"
