extends JournalPage

class_name JournalPagePredator

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- Tends to wander aimlessly."
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateWander.text = "- Tends to wander aimlessly. Rarely, if ever, runs."
				progress += 1
			if times_found == 30:
				$StateWander.text = "- When not looking for food, will leisurely patrol their home area."
				progress += 1
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- Off-white in color."
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateIdle.text = "- Off-white in color. Around 1’6” in length."
				progress += 1
			if times_found == 30:
				$StateIdle.text = "- Off-white in color. Around 1’6” in length. Large, emotive ears."
				progress += 1
		"Attack Eat":
			if times_found == 1:
				$StateEat.text = "- Enjoys eating fruit."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateEat.text = "- Eats primarily fruit. Their favorite is large, red, juicy fruits."
				progress += 1
			if times_found == 10:
				$StateEat.text = "- Can eat their entire body weight in fruit a single day."
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- Takes short naps every so often to restore energy."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateRest.text = "- To avoid danger, sleeps only in short bursts."
				progress += 1
			if times_found == 10:
				$StateRest.text = "- Their highly efficient bodies can restore plenty of energy from just a short nap."
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- Their fur is soft and velvety."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- Being pet seems to calm them down. They enjoy it a lot."
				progress += 1
			if times_found == 10:
				$StatePet.text = "- Enjoys being pet, particularly being scratched behind the ears."
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- Becomes agitated when poked."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- Struggles to sit still when agitated."
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- Shockingly short-tempered, even a couple of pokes will whip them into a frenzy."
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- Will sometimes jump around and make squeaking noises with others of their species."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- Jumping around with others seems to lower their stress."
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- Will play with others of their species by jumping around and making squeaking noises."
				progress += 1
		"Eat":
			if times_found == 1:
				$StateChase.text = "- Runs around when agitated."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateChase.text = "- When agitated, will often seek out and attack others of their kind."
				progress += 1
			if times_found == 10:
				$StateChase.text = "- When agitated, will seek out and attack others of their kind until calming down."
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- Fights primarily by biting."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- Fights using their sharp front teeth, strong enough to chew through wood!"
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- With their sharp front teeth that can chew through wood, they nip at anything nearby."
				progress += 1
		"Intimidate":
			if times_found == 1:
				$StateFlee.text = "- Flees when attacked."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- When attacked, tends to panic and run aimlessly."
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- Will panic and run aimlessly when attacked, curling their tail and ears inward to protect them."
				progress += 1
	
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(found_states_creature)
	
	update_progress()
