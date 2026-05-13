extends JournalPage

class_name JournalPageBoss

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
@onready var state_attack_eat: Label = $Container/StateAttackEat

@onready var state_wander_update: Sprite2D = $Container/StateWander/UpdateLabel
@onready var state_idle_update: Sprite2D = $Container/StateIdle/UpdateLabel
@onready var state_eat_update: Sprite2D = $Container/StateEat/UpdateLabel
@onready var state_rest_update: Sprite2D = $Container/StateRest/UpdateLabel
@onready var state_pet_update: Sprite2D = $Container/StatePet/UpdateLabel
@onready var state_poke_update: Sprite2D = $Container/StatePoke/UpdateLabel
@onready var state_play_update: Sprite2D = $Container/StatePlay/UpdateLabel
@onready var state_chase_update: Sprite2D = $Container/StateChase/UpdateLabel
@onready var state_attack_update: Sprite2D = $Container/StateAttack/UpdateLabel
@onready var state_attack_eat_update: Sprite2D = $Container/StateAttackEat/UpdateLabel

@onready var states_found_label: Label = $Container/StatesFound
@onready var progress_label: Label = $Container/Progress
@onready var instructions_label: Label = $Container/Instructions

@onready var hidden_sprite: Sprite2D = $Container/HiddenSprite

func on_state_found(found_state: StringName, times_found: int) -> void:
	
	match found_state:
		"Wander":
			if times_found == 1:
				state_wander.text = "- WANDER: Wanders about, looking for something interesting."
				state_wander.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				state_wander_update.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_wander.text = "- WANDER: Wanders aimlessly until something exciting happens."
				state_wander_update.visible = true
				progress += 1
			if times_found == 10:
				state_wander.text = "- WANDER: Shakes the ground as it searches for excitement."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				state_idle.text = "- IDLE: Pale in color with a gigantic mouth."
				state_idle.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				state_idle_update.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_idle.text = "- IDLE: Covered in pale fur, with a large mouth and horns."
				state_idle_update.visible = true
				progress += 1
			if times_found == 10:
				state_idle.text = "- IDLE: Covered in dense, shaggy fur. Its teeth are sharp!"
				state_idle_update.visible = true
				state_idle.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Eat":
			if times_found == 1:
				state_eat.text = "- EAT: Can eat an entire apple in two bites."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_eat.text = "- EAT: Loves eating apples, which it devours in huge bites."
				state_eat_update.visible = true
				progress += 1
			if times_found == 10:
				state_eat.text = "- EAT: Rushes toward any food it sees, particularly apples."
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				state_rest.text = "- REST: Said to sleep for 50 years, but it still takes naps."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_rest.text = "- REST: Takes short naps to replenish its endless energy."
				state_rest_update.visible = true
				progress += 1
			if times_found == 10:
				state_rest.text = "- REST: To make the most of its waking hours, it takes short naps."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				state_pet.text = "- PET: Fur is soft, dense, and shaggy."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_pet.text = "- PET: Enjoys being pet, but its dense fur makes it difficult."
				state_pet_update.visible = true
				progress += 1
			if times_found == 10:
				state_pet.text = "- PET: Loves to be pet, especially behind the ears."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Alerted":
			if times_found == 1:
				state_poke.text = "- ALERT: Sees being poked as an invitation to play."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_poke.text = "- ALERT: Becomes excited when poked, seeking out a playmate."
				state_poke_update.visible = true
				progress += 1
			if times_found == 10:
				state_poke.text = "- ALERT: Becomes excited by almost any contact, poking included."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				state_play.text = "- PLAY: Will play with anyone and anything."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_play.text = "- PLAY: Plays by bowing down and bounding about."
				state_play_update.visible = true
				progress += 1
			if times_found == 10:
				state_play.text = "- PLAY: The ground shakes whenever it plays."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Chase":
			if times_found == 1:
				state_chase.text = "- CHASE: Chases down targets at frightening speed."
				state_chase_update.visible = true
				state_chase.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_chase.text = "- CHASE: When excited, will chase down playmates aggressively."
				state_chase_update.visible = true
				progress += 1
			if times_found == 10:
				state_chase.text = "- CHASE: Runs endlessly towards 'playmates' to fight."
				state_chase_update.visible = true
				state_chase.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				state_attack.text = "- ATTACK: Fights using its crushing jaws."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_attack.text = "- ATTACK: Its bite is strong enough to instantly fell anyone."
				state_attack_update.visible = true
				progress += 1
			if times_found == 10:
				state_attack.text = "- ATTACK: It doesn't know nothing can withstand its bite."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack Eat":
			if times_found == 1:
				state_attack_eat.text = "- ATTACK EAT: Will bite other creatures on a whim."
				state_attack_eat_update.visible = true
				state_attack_eat.self_modulate = Color(0.0, 0.0, 0.0, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_attack_eat.text = "- ATTACK EAT: Its jaws deplete a creature's energy in one bite."
				state_attack_eat_update.visible = true
				progress += 1
			if times_found == 10:
				state_attack_eat.text = "- ATTACK EAT: Will even attempt to eat its playmates!"
				state_attack_eat_update.visible = true
				state_attack_eat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
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
		instructions_label.text = "Keep up the good work! You've got this!"
		
	if progress == 10:
		instructions_label.text = "Incredible job!"
		
	if progress == 15:
		instructions_label.text = "You're crazy!"
		
	if progress == 30:
		instructions_label.text = "You should probably finish the quest now..."

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
	state_attack_eat_update.visible = false
	
