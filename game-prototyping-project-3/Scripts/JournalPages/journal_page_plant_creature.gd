extends JournalPage

class_name JournalPagePlantCreature

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- Moves very slowly. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateWander.text = "- Only moves when necessary, because of their small, stubby legs. (2/3)"
				progress += 1
			if times_found == 30:
				$StateWander.text = "- To conserve energy, they only move when headed to a sunnier location. (3/3)"
				progress += 1
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- Brown in color, covered in dense foliage. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateIdle.text = "- Their body is covered in a thick bush that grows fruits. (2/3)"
				progress += 1
			if times_found == 30:
				$StateIdle.text = "- Has a symbiotic relationship with their plant cover, which generates energy for them. (3/3)"
				progress += 1
		"Photosynthesize":
			if times_found == 1:
				$StatePhotosynthesize.text = "- Occasionally sits still to absorb sunlight. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePhotosynthesize.text = "- The plant on their back glows when absorbing sunlight. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePhotosynthesize.text = "- Because the plant growing on them creates energy, they rarely eat. (3/3)"
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- Occasionally falls asleep. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateRest.text = "- When they fall asleep, it's very difficult to wake them up. (2/3)"
				progress += 1
			if times_found == 10:
				$StateRest.text = "- To conserve energy, they regularly fall into a deep sleep. (3/3)"
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- Their head is fuzzy, covered in short hairs. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- Their body is fuzzy, but the bush around their body makes it hard to reach. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePet.text = "- Enjoy being pet on the head, but sensitive to their bush being disturbed. (3/3)"
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- Becomes startled when poked. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- Surprisingly, they react more to their bush being poked than their head. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- Difficult to anger, they instead puff up when bothered to protect their fruit. (3/3)"
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- Will occasionally flap their antennae wildly. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- Will play with friendly creatures by rustling their bush and flapping their antennae. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- Relieves stress by playing with friendly creatures, flapping their antennae when happy. (3/3)"
				progress += 1
		"Drop Food":
			if times_found == 1:
				$StateDropFood.text = "- The fruit on their body falls off when ripe. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateDropFood.text = "- Will shake to cause ripened fruit to fall off their body. (2/3)"
				progress += 1
			if times_found == 10:
				$StateDropFood.text = "- The fruit they drop from their body allows their seeds to spread when eaten. (3/3)"
				progress += 1
		"Poison":
			if times_found == 1:
				$StatePoison.text = "- When attacked, shakes wildly to scare off predators. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoison.text = "- Shakes wildly to scatter a poisonous dust when threatened. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePoison.text = "- The toxic dust they produce to defend themselves will deter almost any predator. (3/3)"
				progress += 1
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- Flees when attacked. (1/3)"
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- Will attempt to run away when attacked and out of poison. (2/3)"
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- When left defenseless, they will attempt to run away, but they are slow. (3/3)"
				progress += 1
	
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(found_states_creature)
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
