extends JournalPage

class_name JournalPagePlantCreature

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				$StateWander.text = "- WANDER: Moves very slowly."
				$StateWander/UpdateLabel.visible = true
				$StateWander.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateWander.text = "- WANDER: Only moves when necessary, because of their short legs."
				$StateWander/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateWander.text = "- WANDER: To conserve energy, they only move when needed."
				$StateWander/UpdateLabel.visible = true
				$StateWander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Idle":
			if times_found == 1:
				$StateIdle.text = "- IDLE: Brown in color, covered in dense foliage."
				$StateIdle/UpdateLabel.visible = true
				$StateIdle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateIdle.text = "- IDLE: Their body is covered in a thick bush that grows fruits."
				$StateIdle/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateIdle.text = "- IDLE: Has a symbiotic relationship with their bush cover, which generates energy."
				$StateIdle/UpdateLabel.visible = true
				$StateIdle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Photosynthesize":
			if times_found == 1:
				$StatePhotosynthesize.text = "- PHOTO.: Occasionally sits still to absorb sunlight."
				$StatePhotosynthesize/UpdateLabel.visible = true
				$StatePhotosynthesize.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePhotosynthesize.text = "- PHOTO.: The plant on their back glows when absorbing sunlight."
				$StatePhotosynthesize/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePhotosynthesize.text = "- PHOTO.: They rarely need to eat, but they can't absorb light when tired."
				$StatePhotosynthesize/UpdateLabel.visible = true
				$StatePhotosynthesize.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				$StateRest.text = "- REST: Occasionally falls asleep."
				$StateRest/UpdateLabel.visible = true
				$StateRest.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateRest.text = "- REST: When they fall asleep, it's very difficult to wake them up."
				$StateRest/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateRest.text = "- REST: To conserve energy, they regularly fall into a deep sleep."
				$StateRest/UpdateLabel.visible = true
				$StateRest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				$StatePet.text = "- PET: Their head is fuzzy, covered in short hairs."
				$StatePet/UpdateLabel.visible = true
				$StatePet.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePet.text = "- PET: Being pet seems to make them less stressed."
				$StatePet/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePet.text = "- PET: Being pet relieves stress, causing them to be healthier overall."
				$StatePet/UpdateLabel.visible = true
				$StatePet.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Annoyed":
			if times_found == 1:
				$StatePoke.text = "- ANNOY: Becomes startled when poked."
				$StatePoke/UpdateLabel.visible = true
				$StatePoke.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoke.text = "- ANNOY: When poked, their fruit will drop off if ripe."
				$StatePoke/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePoke.text = "- ANNOY: When poked, their fruit will drop off if ripe. Becoming too annoyed makes them leave."
				$StatePoke/UpdateLabel.visible = true
				$StatePoke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				$StatePlay.text = "- PLAY: Will play with friendly creatures by rustling their bush and flapping their antennae."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePlay.text = "- PLAY: Relieves stress by playing with friendly creatures."
				$StatePlay/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePlay.text = "- They need to play regularly or they will become unhealthy, but they are lazy."
				$StatePlay/UpdateLabel.visible = true
				$StatePlay.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Drop Food":
			if times_found == 1:
				$StateDropFood.text = "- DROP FOOD: The fruit on their body falls off when ripe."
				$StateDropFood/UpdateLabel.visible = true
				$StateDropFood.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateDropFood.text = "- DROP FOOD: Will shake to cause ripened fruit to fall off their body."
				$StateDropFood/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateDropFood.text = "- DROP FOOD: The fruit they drop from their body is eaten by many other creatures."
				$StateDropFood/UpdateLabel.visible = true
				$StateDropFood.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Poison Dust":
			if times_found == 1:
				$StatePoison.text = "- POISON: Shakes wildly to scatter a poisonous dust when threatened."
				$StatePoison/UpdateLabel.visible = true
				$StatePoison.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StatePoison.text = "- POISON: The toxic dust they produce to defend themselves will deter almost any predator."
				$StatePoison/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StatePoison.text = "- POISON: Scatters poison dust to deter predators, but it takes some time to regrow."
				$StatePoison/UpdateLabel.visible = true
				$StatePoison.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				$StateFlee.text = "- FLEE: Runs away when attacked and out of poison."
				$StateFlee/UpdateLabel.visible = true
				$StateFlee.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				$StateFlee.text = "- FLEE: When left defenseless, they will attempt to run away, but they are slow."
				$StateFlee/UpdateLabel.visible = true
				progress += 1
			if times_found == 10:
				$StateFlee.text = "- FLEE: Runs away when out of poison dust, to recover health through photosynthesis."
				$StateFlee/UpdateLabel.visible = true
				$StateFlee.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
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
	$StatePhotosynthesize/UpdateLabel.visible = false
	$StateRest/UpdateLabel.visible = false
	$StatePet/UpdateLabel.visible = false
	$StatePoke/UpdateLabel.visible = false
	$StatePlay/UpdateLabel.visible = false
	$StateDropFood/UpdateLabel.visible = false
	$StatePoison/UpdateLabel.visible = false
	$StateFlee/UpdateLabel.visible = false
