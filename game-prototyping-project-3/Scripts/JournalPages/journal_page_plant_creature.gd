extends JournalPage

class_name JournalPagePlantCreature

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- Moves very slowly. (1/3)"
				$StateWander.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateWander.text = "- Only moves when necessary, because of their small, stubby legs. (2/3)"
				progress += 1
			if times_found == 30:
				$StateWander.text = "- To conserve energy, they only move when needed. (3/3)"
				progress += 1
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- Brown in color, covered in dense foliage. (1/3)"
				$StateIdle.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 15:
				$StateIdle.text = "- Their body is covered in a thick bush that grows fruits. (2/3)"
				progress += 1
			if times_found == 30:
				$StateIdle.text = "- Has a symbiotic relationship with their bush cover, which generates energy. (3/3)"
				progress += 1
		"Photosynthesize":
			if times_found == 1:
				$StatePhotosynthesize.text = "- Occasionally sits still to absorb sunlight. (1/3)"
				$StatePhotosynthesize.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePhotosynthesize.text = "- The plant on their back glows when absorbing sunlight. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePhotosynthesize.text = "- They rarely need to eat, but they can't photosynthesize when tired. (3/3)"
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- Occasionally falls asleep. (1/3)"
				$StateRest.modulate = Color(0.0, 0.0, 0.0, 1.0)
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
				$StatePet.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- Being pet seems to make them less stressed. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePet.text = "- Being pet relieves stress, causing them to  (3/3)"
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- Becomes startled when poked. (1/3)"
				$StatePoke.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- When poked, their fruit will drop off if ripe. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- When poked, their fruit will drop off if ripe. Becoming too annoyed makes them leave. (3/3)"
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- Will play with friendly creatures by rustling their bush and flapping their antennae. (1/3)"
				$StatePlay.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- Relieves stress by playing with friendly creatures, flapping their antennae when happy. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- They need to play regularly or they will become unhealthy, but they are lazy. (3/3)"
				progress += 1
		"Drop Food":
			if times_found == 1:
				$StateDropFood.text = "- The fruit on their body falls off when ripe. (1/3)"
				$StateDropFood.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateDropFood.text = "- Will shake to cause ripened fruit to fall off their body. (2/3)"
				progress += 1
			if times_found == 10:
				$StateDropFood.text = "- The fruit they drop from their body is eaten by many other creatures. (3/3)"
				progress += 1
		"Poison":
			if times_found == 1:
				$StatePoison.text = "- Shakes wildly to scatter a poisonous dust when threatened. (1/3)"
				$StatePoison.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoison.text = "- The toxic dust they produce to defend themselves will deter almost any predator. (2/3)"
				progress += 1
			if times_found == 10:
				$StatePoison.text = "- Scatters poison dust to deter predators, but it takes some time to regrow. (3/3)"
				progress += 1
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- Runs away when attacked and out of poison. (1/3)"
				$StateFlee.modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- When left defenseless, they will attempt to run away, but they are slow. (2/3)"
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- Runs away when out of poison dust, to recover health through photosynthesis. (3/3)"
				progress += 1
	
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(found_states_creature)
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
