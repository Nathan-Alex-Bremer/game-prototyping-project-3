extends JournalPage

class_name JournalPagePredator

# Variables
@onready var state_wander: Label = $Container/StateWander
@onready var state_idle: Label = $Container/StateIdle
@onready var state_eat: Label = $Container/StateEat
@onready var state_rest: Label = $Container/StateRest
@onready var state_pet: Label = $Container/StatePet
@onready var state_poke: Label = $Container/StatePoke
@onready var state_play: Label = $Container/StatePlay
@onready var state_attack_eat: Label = $Container/StateAttackEat
@onready var state_attack: Label = $Container/StateAttack
@onready var state_intimidate: Label = $Container/StateIntimidate

@onready var state_wander_update: Sprite2D = $Container/StateWander/UpdateLabel
@onready var state_idle_update: Sprite2D = $Container/StateIdle/UpdateLabel
@onready var state_attack_eat_update: Sprite2D = $Container/StateAttackEat/UpdateLabel
@onready var state_eat_update: Sprite2D = $Container/StateEat/UpdateLabel
@onready var state_rest_update: Sprite2D = $Container/StateRest/UpdateLabel
@onready var state_pet_update: Sprite2D = $Container/StatePet/UpdateLabel
@onready var state_poke_update: Sprite2D = $Container/StatePoke/UpdateLabel
@onready var state_play_update: Sprite2D = $Container/StatePlay/UpdateLabel
@onready var state_attack_update: Sprite2D = $Container/StateAttack/UpdateLabel
@onready var state_intimidate_update: Sprite2D = $Container/StateIntimidate/UpdateLabel

@onready var states_found_label: Label = $Container/StatesFound
@onready var progress_label: Label = $Container/Progress
@onready var instructions_label: Label = $Container/Instructions

@onready var hidden_sprite: Sprite2D = $Container/HiddenSprite

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				state_wander.text = "- WANDER: Will often wander aimlessly."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_wander.text = "- WANDER: Patrols constantly when hungry or annoyed."
				state_wander_update.visible = true
				progress += 1
			if times_found == 10:
				state_wander.text = "- WANDER: Always on patrol, but will stick near their partner."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Idle":
			if times_found == 1:
				state_idle.text = "- IDLE: Orange in color, with a flaming tail."
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_idle.text = "- IDLE: Orange in color. Their tail changes with energy level."
				state_idle_update.visible = true
				progress += 1
			if times_found == 10:
				state_idle.text = "- IDLE: Covered in fireproof fur. Their tail shows their energy."
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack Eat":
			if times_found == 1:
				state_attack_eat.text = "- ATTACK EAT: Will hunt smaller creatures for food."
				state_attack_eat_update.visible = true
				state_attack_eat.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_attack_eat.text = "- ATTACK EAT: Prefers hunting to eating fruit."
				state_attack_eat_update.visible = true
				progress += 1
			if times_found == 10:
				state_attack_eat.text = "- ATTACK EAT: Hunts alone, but their partner will defend them."
				state_attack_eat_update.visible = true
				state_attack_eat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				state_rest.text = "- REST: Regularly takes naps when tired."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_rest.text = "- REST: Sleeps often and in short bursts to recover stamina."
				state_rest_update.visible = true
				progress += 1
			if times_found == 10:
				state_rest.text = "- REST: When their partner sleeps, they stand guard."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				state_pet.text = "- PET: Covered in shaggy fur."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_pet.text = "- PET: Despite appearances, they become friendly when pet."
				state_pet_update.visible = true
				progress += 1
			if times_found == 10:
				state_pet.text = "- PET: Greatly enjoys being pet, and will calm down afterward."
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
				state_poke.text = "- ANNOY: Short-tempered. Flares their tail when bothered."
				state_poke_update.visible = true
				progress += 1
			if times_found == 10:
				state_poke.text = "- ANNOY: Annoyed by pokes, seeking fights and flaring their tail."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				state_play.text = "- PLAY: Enjoys playing with their partner."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_play.text = "- PLAY: Will only ever play with their partner."
				state_play_update.visible = true
				progress += 1
			if times_found == 10:
				state_play.text = "- PLAY: Plays with their partner to relieve stress."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Eat":
			if times_found == 1:
				state_eat.text = "- EAT: Will occasionally eat fruit if especially hungry."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_eat.text = "- EAT: While they prefer meat, they will also eat fruit."
				state_eat_update.visible = true
				progress += 1
			if times_found == 10:
				state_eat.text = "- EAT: Despite preferring meat, fruit fills them up more."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				state_attack.text = "- ATTACK: Attacks with sharp fangs when annoyed."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_attack.text = "- ATTACK: When attacked, will fight alongside their partner."
				state_attack_update.visible = true
				progress += 1
			if times_found == 10:
				state_attack.text = "- ATTACK: Fights alongside a partner, but will flee if injured."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Intimidate":
			if times_found == 1:
				state_intimidate.text = "- INTIMIDATE: Puffe up to scare anything nearby when stressed."
				state_intimidate_update.visible = true
				state_intimidate.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_intimidate.text = "- INTIMIDATE: Will attempt to scare others in order to de-stress."
				state_intimidate_update.visible = true
				progress += 1
			if times_found == 10:
				state_intimidate.text = "- INTIMIDATE: Scares others by flaring their tail, lowering stress."
				state_intimidate_update.visible = true
				state_intimidate.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
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
	state_attack_eat_update.visible = false
	state_rest_update.visible = false
	state_pet_update.visible = false
	state_poke_update.visible = false
	state_play_update.visible = false
	state_eat_update.visible = false
	state_attack_update.visible = false
	state_intimidate_update.visible = false
