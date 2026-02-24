extends JournalPage

class_name JournalPagePredator

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- WANDER: Will often wander aimlessly."
				$StateWander.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateWander.text = "- WANDER: Patrols constantly when hungry or annoyed."
				progress += 1
			if times_found == 10:
				$StateWander.text = "- WANDER: Will constantly patrol, but will stick close to their partner."
				$StateWander.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- IDLE: Orange in color, with a flaming tail."
				$StateIdle.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIdle.text = "- IDLE: Orange in color. Their flaming tail changes with energy level."
				progress += 1
			if times_found == 10:
				$StateIdle.text = "- IDLE: Sleek, and covered in fireproof fur. Their tail changes with energy level."
				$StateIdle.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack Eat":
			if times_found == 1:
				$StateAttackEat.text = "- ATTACK EAT: Will hunt smaller Creatures for food."
				$StateAttackEat.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttackEat.text = "- ATTACK EAT: Prefers hunting smaller creatures to eating fruit."
				progress += 1
			if times_found == 10:
				$StateAttackEat.text = "- ATTACK EAT: Hunts alone, but their partner will step in if the prey fights back."
				$StateAttackEat.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- REST: Regularly takes naps when tired."
				$StateRest.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateRest.text = "- REST: Sleeps often and in short bursts to recover stamina."
				progress += 1
			if times_found == 10:
				$StateRest.text = "- REST: When their partner sleeps, they stay awake to stand guard."
				$StateRest.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- PET: Covered in shaggy fur."
				$StatePet.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- PET: Despite appearances, they become friendly when pet."
				progress += 1
			if times_found == 10:
				$StatePet.text = "- PET: Greatly enjoy being pet, and will become much calmer afterward."
				$StatePet.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- ANNOY: Becomes agitated when poked."
				$StatePoke.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- ANNOY: Short-tempered, and will flare their tails when bothered."
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- ANNOY: Easily annoyed by pokes, seeking fights and flaring their tail."
				$StatePoke.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- PLAY: Enjoys playing with their partner."
				$StatePlay.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- PLAY: Will only ever play with their partner, laughing and jumping around."
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- PLAY: Plays with their partner to relieve stress, but will sometimes scare them off."
				$StatePlay.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Eat":
			if times_found == 1:
				$StateEat.text = "- EAT: Will occasionally eat fruit if especially hungry."
				$StateEat.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateEat.text = "- EAT: While they prefer meat, they will eat fruit if there is no other option."
				progress += 1
			if times_found == 10:
				$StateEat.text = "- EAT: While they prefer meat, they will also eat fruit, which fills them up more."
				$StateEat.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				$StateAttack.text = "- ATTACK: Attacks with sharp fangs when annoyed."
				$StateAttack.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateAttack.text = "- ATTACK: When attacked, they will fight back alongside their partner."
				progress += 1
			if times_found == 10:
				$StateAttack.text = "- ATTACK: Fights alongside a partner if able, but will flee if injured."
				$StateAttack.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Intimidate":
			if times_found == 1:
				$StateIntimidate.text = "- INTIMIDATE: Puffe up to intimidate anything nearby when stressed."
				$StateIntimidate.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIntimidate.text = "- INTIMIDATE: Will attempt to intimidate nearby creatures in order to de-stress."
				progress += 1
			if times_found == 10:
				$StateIntimidate.text = "- INTIMIDATE: When irritated, will flare their tail - this can even scare their partner!"
				$StateIntimidate.modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
	
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(found_states_creature)
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
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
