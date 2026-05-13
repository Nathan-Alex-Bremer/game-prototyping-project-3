extends JournalPage

class_name JournalPageBird

# Variables
@onready var state_wander: Label = $Container/StateWander
@onready var state_idle: Label = $Container/StateIdle
@onready var state_eat: Label = $Container/StateEat
@onready var state_rest: Label = $Container/StateRest
@onready var state_pet: Label = $Container/StatePet
@onready var state_poke: Label = $Container/StatePoke
@onready var state_play: Label = $Container/StatePlay
@onready var state_chase: Label = $Container/StateChase
@onready var state_attack: Label = $Container/StateAttack
@onready var state_flee: Label = $Container/StateFlee

@onready var state_wander_update: Sprite2D = $Container/StateWander/UpdateLabel
@onready var state_idle_update: Sprite2D = $Container/StateIdle/UpdateLabel
@onready var state_eat_update: Sprite2D = $Container/StateEat/UpdateLabel
@onready var state_rest_update: Sprite2D = $Container/StateRest/UpdateLabel
@onready var state_pet_update: Sprite2D = $Container/StatePet/UpdateLabel
@onready var state_poke_update: Sprite2D = $Container/StatePoke/UpdateLabel
@onready var state_play_update: Sprite2D = $Container/StatePlay/UpdateLabel
@onready var state_chase_update: Sprite2D = $Container/StateChase/UpdateLabel
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
				state_wander.text = "- WANDER: Constantly flies about."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_wander.text = "- WANDER: Constantly flying. Will flee from humans."
				state_wander_update.visible = true
				progress += 1
			if times_found == 10:
				state_wander.text = "- WANDER: Constantly flying. Will flee from humans if on edge."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				state_idle.text = "- IDLE: Blue in color."
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_idle.text = "- IDLE: Blue in color, with some sort of marking on its chest."
				state_idle_update.visible = true
				progress += 1
			if times_found == 10:
				state_idle.text = "- IDLE: Blue in color. Organs on its chest increase flight speed."
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Eat":
			if times_found == 1:
				state_eat.text = "- EAT: Enjoys eating fruit."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_eat.text = "- EAT: Eats primarily fruit. They particularly enjoy apples."
				state_eat_update.visible = true
				progress += 1
			if times_found == 10:
				state_eat.text = "- EAT: Easily distracted by the fruit it loves so much."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				state_rest.text = "- REST: Takes short naps every so often to restore energy."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_rest.text = "- REST: To avoid danger, sleeps only in short bursts."
				state_rest_update.visible = true
				progress += 1
			if times_found == 10:
				state_rest.text = "- REST: Only rarely sleeps, to avoid being caught off-guard."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				state_pet.text = "- PET: Has soft feathers."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_pet.text = "- PET: Being pet seems to calm them down and make them friendly."
				state_pet_update.visible = true
				progress += 1
			if times_found == 10:
				state_pet.text = "- PET: Being pet calms them down and makes them warm up to people."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Annoyed":
			if times_found == 1:
				state_poke.text = "- ANNOY: Becomes agitated when poked."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_poke.text = "- ANNOY: Will fly away when poked."
				state_poke_update.visible = true
				progress += 1
			if times_found == 10:
				state_poke.text = "- ANNOY: Will fly away when poked, but rarely becomes aggressive."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				state_play.text = "- PLAY: Will sometimes stop to bob their head and sing."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_play.text = "- PLAY: Plays by singing and bobbing their head."
				state_play_update.visible = true
				progress += 1
			if times_found == 10:
				state_play.text = "- PLAY: Plays by singing and bobbing their head, reducing stress."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Chase":
			if times_found == 1:
				state_chase.text = "- CHASE: Flies around when agitated."
				state_chase_update.visible = true
				state_chase.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_chase.text = "- CHASE: When agitated, will often attack anything in sight."
				state_chase_update.visible = true
				progress += 1
			if times_found == 10:
				state_chase.text = "- CHASE: When angered, will chase down others until worn out."
				state_chase_update.visible = true
				state_chase.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				state_attack.text = "- ATTACK: Fights primarily with their claws."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_attack.text = "- ATTACK: Fights using their sharp talons from mid-air."
				state_attack_update.visible = true
				progress += 1
			if times_found == 10:
				state_attack.text = "- ATTACK: Using their sharp talons, they can ward off any foe."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				state_flee.text = "- FLEE: Will flee when attacked."
				state_flee_update.visible = true
				state_flee.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_flee.text = "- FLEE: When attacked, will try to escape the assailant."
				state_flee_update.visible = true
				progress += 1
			if times_found == 10:
				state_flee.text = "- FLEE: Will flee when they feel unsafe, such as when attacked."
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
	state_rest_update.visible = false
	state_pet_update.visible = false
	state_poke_update.visible = false
	state_play_update.visible = false
	state_chase_update.visible = false
	state_attack_update.visible = false
	state_flee_update.visible = false
