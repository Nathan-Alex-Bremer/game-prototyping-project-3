extends JournalPage

class_name JournalPageMoth

# Variables
@onready var state_wander: Label = $Container/StateWander
@onready var state_idle: Label = $Container/StateIdle
@onready var state_eat: Label = $Container/StateEat
@onready var state_pollinate: Label = $Container/StatePollinate
@onready var state_pet: Label = $Container/StatePet
@onready var state_poke: Label = $Container/StatePoke
@onready var state_play: Label = $Container/StatePlay
@onready var state_spread_pollen: Label = $Container/StateSpreadPollen
@onready var state_attack: Label = $Container/StateAttack
@onready var state_flee: Label = $Container/StateFlee

@onready var state_wander_update: Sprite2D = $Container/StateWander/UpdateLabel
@onready var state_idle_update: Sprite2D = $Container/StateIdle/UpdateLabel
@onready var state_eat_update: Sprite2D = $Container/StateEat/UpdateLabel
@onready var state_pollinate_update: Sprite2D = $Container/StatePollinate/UpdateLabel
@onready var state_pet_update: Sprite2D = $Container/StatePet/UpdateLabel
@onready var state_poke_update: Sprite2D = $Container/StatePoke/UpdateLabel
@onready var state_play_update: Sprite2D = $Container/StatePlay/UpdateLabel
@onready var state_spread_pollen_update: Sprite2D = $Container/StateSpreadPollen/UpdateLabel
@onready var state_attack_update: Sprite2D = $Container/StateAttack/UpdateLabel
@onready var state_flee_update: Sprite2D = $Container/StateFlee/UpdateLabel

@onready var states_found_label: Label = $Container/StatesFound
@onready var progress_label: Label = $Container/Progress
@onready var instructions_label: Label = $Container/Instructions

@onready var hidden_sprite: Sprite2D = $Container/HiddenSprite

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				state_wander.text = "- WANDER: Flits about aimlessly."
				state_wander.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				state_wander_update.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_wander.text = "- WANDER: Flies in seemingly random directions."
				state_wander_update.visible = true
				progress += 1
			if times_found == 10:
				state_wander.text = "- WANDER: Flies in various directions looking for plants."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				state_idle.text = "- IDLE: Purple in color."
				state_idle.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				state_idle_update.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_idle.text = "- IDLE: Purple, but has yellow wings with odd markings."
				state_idle_update.visible = true
				progress += 1
			if times_found == 10:
				state_idle.text = "- IDLE: Purple, with yellow wings marked with eyespots."
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Eat":
			if times_found == 1:
				state_eat.text = "- EAT: Enjoys eating fruit."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_eat.text = "- EAT: Sucks moisture out of fruit with their tongue."
				state_eat_update.visible = true
				progress += 1
			if times_found == 10:
				state_eat.text = "- EAT: Enjoys eating fruit for moisture and nutrients."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pollinate":
			if times_found == 1:
				state_pollinate.text = "- POLLINATE: Enjoys being around Bittybush."
				state_pollinate_update.visible = true
				state_pollinate.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_pollinate.text = "- POLLINATE: Collects pollen from Bittybush."
				state_pollinate_update.visible = true
				progress += 1
			if times_found == 10:
				state_pollinate.text = "- POLLINATE: Pollinates Bittybush bushes as they fly."
				state_pollinate_update.visible = true
				state_pollinate.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				state_pet.text = "- PET: Surprisingly fuzzy."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_pet.text = "- PET: Covered in fuzz that gathers pollen."
				state_pet_update.visible = true
				progress += 1
			if times_found == 10:
				state_pet.text = "- PET: Their fuzz is charged to attract pollen."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Annoyed":
			if times_found == 1:
				state_poke.text = "- ANNOY: Becomes agitated when poked."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_poke.text = "- ANNOY: Will shake and squeak when poked."
				state_poke_update.visible = true
				progress += 1
			if times_found == 10:
				state_poke.text = "- ANNOY: Makes a squeaking noise when angry using their wings."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				state_play.text = "- PLAY: Plays by fluttering around."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_play.text = "- PLAY: Flies around creatures for fun."
				state_play_update.visible = true
				progress += 1
			if times_found == 10:
				state_play.text = "- PLAY: Mischevious when it plays."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Spread Pollen":
			if times_found == 1:
				state_spread_pollen.text = "- SPREAD POLLEN: Scatters pollen when flying."
				state_spread_pollen_update.visible = true
				state_spread_pollen.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_spread_pollen.text = "- SPREAD POLLEN: The pollen it scatters grows flowers."
				state_spread_pollen_update.visible = true
				progress += 1
			if times_found == 10:
				state_spread_pollen.text = "- SPREAD POLLEN: Spreads all kinds of flowers."
				state_spread_pollen_update.visible = true
				state_spread_pollen.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				state_attack.text = "- ATTACK: Uses their stinger to fight."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_attack.text = "- ATTACK: Injects foes with a poison stinger."
				state_attack_update.visible = true
				progress += 1
			if times_found == 10:
				state_attack.text = "- ATTACK: Chases foes down and stings them when threatened."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				state_flee.text = "- FLEE: Flits around aimlessly when attacked."
				state_flee_update.visible = true
				state_flee.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_flee.text = "- FLEE: When attacked, flies away rapidly changing directions."
				state_flee_update.visible = true
				progress += 1
			if times_found == 10:
				state_flee.text = "- FLEE: Tries to evade attackers as they flee."
				state_flee_update.visible = true
				state_flee.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
	
	# This is such a gross way to do it
	states_found_label.text = "Found States: " + str(int(found_states_creature))
	
	update_progress()

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	print("Progress:" + str(progress))
	print("Total States: " + str(total_states))
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
	state_eat_update.visible = false
	state_pollinate_update.visible = false
	state_pet_update.visible = false
	state_poke_update.visible = false
	state_play_update.visible = false
	state_spread_pollen_update.visible = false
	state_attack_update.visible = false
	state_flee_update.visible = false
	
