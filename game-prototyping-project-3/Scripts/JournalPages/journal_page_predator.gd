extends JournalPage

class_name JournalPagePredator

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- Will often wander aimlessly. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateWander.text = "- Slowly, peacefully patrols the area aroung their home. (2/3)"
				progress += 1
			if times_found == 30:
				$StateWander.text = "- They spend the bulk of their day patrolling for threats and food. (3/3)"
				progress += 1
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- Orange in color, with a flaming tail. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateIdle.text = "- Orange in color. Their flaming tail changes with energy level. (2/3)"
				progress += 1
			if times_found == 30:
				$StateIdle.text = "- Sleek, and covered in fireproof orange fur. Their flaming tail changes with energy level. (3/3)"
				progress += 1
		"Attack Eat":
			if times_found == 1:
				$StateAttackEat.text = "- Will hunt smaller Creatures for food."
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttackEat.text = "- Attacks smaller Creatures to absorb their energy."
				progress += 1
			if times_found == 10:
				$StateAttackEat.text = "- Tends to hunt alone, searching for smaller Creatures to absorb energy from. (3/3)"
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- Regularly takes naps. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateRest.text = "- Sleeps often and in short bursts to recover stamina. (2/3)"
				progress += 1
			if times_found == 10:
				$StateRest.text = "- When their partner sleeps, they stay awake to stand guard. (3/3)"
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- Covered in shaggy fur. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- Despite appearances, they become friendly when pet. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePet.text = "- Greatly enjoy being pet, especially on the head, and will complain when petting stops. (3/3)"
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- Becomes agitated when poked. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- Short-tempered, and will flare their tails when bothered. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- Easily annoyed by poked, causing their tail to heat up dramatically. (3/3)"
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- Occasionally laughs to relieve stress. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- Players by jumping around and laughing with others of their species. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- Will only ever play with their partner, laughing and jumping around. (3/3)"
				progress += 1
		"Eat":
			if times_found == 1:
				$StateEat.text = "- Will occasionally eat fruit. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateEat.text = "- While they prefer meat, they will occasionally eat fruit, as well. (2/3)"
				progress += 1
			if times_found == 10:
				$StateEat.text = "- While they prefer meat, they will eat fruit if needed, and seem to enjoy it. (3/3)"
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- Attacks with sharp fangs. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- Primarily fight using their fangs, but also use claws and fire breath. (2/3)"
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- Using their fangs, claws, and fire, they often fight alongside their partner. (3/3)"
				progress += 1
		"Intimidate":
			if times_found == 1:
				$StateIntimidate.text = "- Occasionally puff out their fur and flare their tail. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIntimidate.text = "- Puff up to intimidate anything nearby when stressed. (2/3)"
				progress += 1
			if times_found == 10:
				$StateIntimidate.text = "- When irritated, will puff up and flare their tail - this can even scare their partner! (3/3)"
				progress += 1
	
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(found_states_creature)
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
