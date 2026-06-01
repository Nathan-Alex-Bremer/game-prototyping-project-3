extends JournalPage

class_name JournalPagePlantCreature

# Variables
@onready var state_wander: Label = $Container/StateWander
@onready var state_idle: Label = $Container/StateIdle
@onready var state_photosynthesize: Label = $Container/StatePhotosynthesize
@onready var state_rest: Label = $Container/StateRest
@onready var state_pet: Label = $Container/StatePet
@onready var state_poke: Label = $Container/StatePoke
@onready var state_play: Label = $Container/StatePlay
@onready var state_drop_food: Label = $Container/StateDropFood
@onready var state_poison: Label = $Container/StatePoison
@onready var state_flee: Label = $Container/StateFlee

@onready var state_wander_update: Sprite2D = $Container/StateWander/UpdateLabel
@onready var state_idle_update: Sprite2D = $Container/StateIdle/UpdateLabel
@onready var state_photosynthesize_update: Sprite2D = $Container/StatePhotosynthesize/UpdateLabel
@onready var state_rest_update: Sprite2D = $Container/StateRest/UpdateLabel
@onready var state_pet_update: Sprite2D = $Container/StatePet/UpdateLabel
@onready var state_poke_update: Sprite2D = $Container/StatePoke/UpdateLabel
@onready var state_play_update: Sprite2D = $Container/StatePlay/UpdateLabel
@onready var state_drop_food_update: Sprite2D = $Container/StateDropFood/UpdateLabel
@onready var state_poison_update: Sprite2D = $Container/StatePoison/UpdateLabel
@onready var state_flee_update: Sprite2D = $Container/StateFlee/UpdateLabel

@onready var states_found_label: Label = $Container/StatesFound
@onready var progress_label: Label = $Container/Progress
@onready var instructions_label: Label = $Container/Instructions

@onready var hidden_sprite: Sprite2D = $Container/HiddenSprite

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				state_wander.text = "- WANDER: Moves very slowly."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_wander.text = "- WANDER: Only moves when necessary, due to their short legs."
				state_wander_update.visible = true
				progress += 1
			if times_found == 10:
				state_wander.text = "- WANDER: To conserve energy, they only move when needed."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Idle":
			if times_found == 1:
				state_idle.text = "- IDLE: Brown in color, covered in dense foliage."
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_idle.text = "- IDLE: Their body is covered in a thick bush that grows fruits."
				state_idle_update.visible = true
				progress += 1
			if times_found == 10:
				state_idle.text = "- IDLE: Has a symbiotic relationship with their enegizing bush."
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Photosynthesize":
			if times_found == 1:
				state_photosynthesize.text = "- PHOTO.: Occasionally sits still to absorb sunlight."
				state_photosynthesize_update.visible = true
				state_photosynthesize.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_photosynthesize.text = "- PHOTO.: The plant on their back glows when absorbing sunlight."
				state_photosynthesize_update.visible = true
				progress += 1
			if times_found == 10:
				state_photosynthesize.text = "- PHOTO.: They never eat, but they can't absorb light when tired."
				state_photosynthesize_update.visible = true
				state_photosynthesize.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				state_rest.text = "- REST: Occasionally falls asleep."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_rest.text = "- REST: When they fall asleep, it's difficult to wake them up."
				state_rest_update.visible = true
				progress += 1
			if times_found == 10:
				state_rest.text = "- REST: To conserve energy, they often fall into a deep sleep."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				state_pet.text = "- PET: Their head is fuzzy, covered in short hairs."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_pet.text = "- PET: Being pet seems to make them less stressed."
				state_pet_update.visible = true
				progress += 1
			if times_found == 10:
				state_pet.text = "- PET: Being pet relieves stress, causing them to be healthier."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Annoyed":
			if times_found == 1:
				state_poke.text = "- ANNOY: Becomes startled when poked."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_poke.text = "- ANNOY: When poked, their fruit will drop off if ripe."
				state_poke_update.visible = true
				progress += 1
			if times_found == 10:
				state_poke.text = "- ANNOY: Poking makes them drop fruit, but can make them leave."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				state_play.text = "- PLAY: Relieves stress by rustling and flapping their antennae."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_play.text = "- PLAY: Relieves stress by playing with friendly creatures."
				state_play_update.visible = true
				progress += 1
			if times_found == 10:
				state_play.text = "- They need to play regularly or they will become unhealthy."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Drop Food":
			if times_found == 1:
				state_drop_food.text = "- DROP FOOD: The fruit on their body falls off when ripe."
				state_drop_food_update.visible = true
				state_drop_food.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_drop_food.text = "- DROP FOOD: Shakes to cause ripe fruit to fall off their body."
				state_drop_food_update.visible = true
				progress += 1
			if times_found == 10:
				state_drop_food.text = "- DROP FOOD: The fruit they drop is eaten by many creatures."
				state_drop_food_update.visible = true
				state_drop_food.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Poison Dust":
			if times_found == 1:
				state_poison.text = "- POISON: Shakes to scatter a poisonous dust when threatened."
				state_poison_update.visible = true
				state_poison.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_poison.text = "- POISON: The toxic dust they scatter will deter any predator."
				state_poison_update.visible = true
				progress += 1
			if times_found == 10:
				state_poison.text = "- POISON: Uses poison as defense, but it takes time to regrow."
				state_poison_update.visible = true
				state_poison.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				state_flee.text = "- FLEE: Runs away when attacked and out of poison."
				state_flee_update.visible = true
				state_flee.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_flee.text = "- FLEE: When left defenseless, will run away, but they are slow."
				state_flee_update.visible = true
				progress += 1
			if times_found == 10:
				state_flee.text = "- FLEE: Runs away when out of poison dust, to recover health."
				state_flee_update.visible = true
				state_flee.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
	
	# This is such a gross way to do it
	states_found_label.text = "Found States: " + str(int(found_states_creature))
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	progress_label.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
	
	if progress == 1:
		hidden_sprite.visible = false
		
	if progress == 5:
		instructions_label.text = "Use interaction modes (Q) to find new states!"
		
	if progress == 10:
		instructions_label.text = "Take lots of photos of a state for more info!"
		
	if progress == 15:
		instructions_label.text = "Journal entries turn green when complete!"
		
	if progress == 30:
		instructions_label.text = "Great job!"

func clear_update_labels() -> void:
	state_wander_update.visible = false
	state_idle_update.visible = false
	state_photosynthesize_update.visible = false
	state_rest_update.visible = false
	state_pet_update.visible = false
	state_poke_update.visible = false
	state_play_update.visible = false
	state_drop_food_update.visible = false
	state_poison_update.visible = false
	state_flee_update.visible = false
