extends JournalPage

class_name JournalPagePredator

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- Will often wander aimlessly. (1/3)"
				$StateWander.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateWander.text = "- Patrols constantly when hungry or annoyed. (2/3)"
				progress += 1
			if times_found == 30:
				$StateWander.text = "- Will constantly patrol, but will stick close to their partner. (3/3)"
				progress += 1
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- Orange in color, with a flaming tail. (1/3)"
				$StateIdle.modulate = Color(0.0, 0.0, 0.0, 1.0)
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
				$StateAttackEat.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttackEat.text = "- Prefers hunting smaller creatures to eating fruit."
				progress += 1
			if times_found == 10:
				$StateAttackEat.text = "- Tends to hunt alone, but their partner will step in if the prey fights back. (3/3)"
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- Regularly takes naps when tired. (1/3)"
				$StateRest.modulate = Color(0.0, 0.0, 0.0, 1.0)
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
				$StatePet.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- Despite appearances, they become friendly when pet. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePet.text = "- Greatly enjoy being pet, and will become much calmer afterward. (3/3)"
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- Becomes agitated when poked. (1/3)"
				$StatePoke.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- Short-tempered, and will flare their tails when bothered. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- Easily annoyed by pokes, seeking fights and flaring their tail. (3/3)"
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- Enjoys playing with their partner. (1/3)"
				$StatePlay.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- Will only ever play with their partner, laughing and jumping around. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- Plays with their partner to relieve stress, but will sometimes scare them off. (3/3)"
				progress += 1
		"Eat":
			if times_found == 1:
				$StateEat.text = "- Will occasionally eat fruit if especially hungry. (1/3)"
				$StateEat.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateEat.text = "- While they prefer meat, they will eat fruit if there is no other option. (2/3)"
				progress += 1
			if times_found == 10:
				$StateEat.text = "- While they prefer meat, they will also eat fruit, which fills them up more. (3/3)"
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- Attacks with sharp fangs when annoyed. (1/3)"
				$StateAttack.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- When attacked, they will fight back alongside their partner. (2/3)"
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- Fights alongside a partner if able, but will flee if injured. (3/3)"
				progress += 1
		"Intimidate":
			if times_found == 1:
				$StateIntimidate.text = "- Puff up to intimidate anything nearby when stressed. (1/3)"
				$StateIntimidate.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIntimidate.text = "- Will attempt to intimidate nearby creatures in order to de-stress. (2/3)"
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
