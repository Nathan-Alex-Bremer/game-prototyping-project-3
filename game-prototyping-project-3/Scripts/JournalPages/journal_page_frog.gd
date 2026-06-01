extends JournalPage

class_name JournalPageFrog

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
				state_wander.text = "- WANDER: Hops around in a carefree manner."
				state_wander.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				state_wander_update.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_wander.text = "- WANDER: Hops along in a straight line when not bothered."
				state_wander_update.visible = true
				progress += 1
			if times_found == 10:
				state_wander.text = "- WANDER: Generally hops in a line, but can turn on a dime."
				state_wander_update.visible = true
				state_wander.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
			
		"Idle":
			if times_found == 1:
				state_idle.text = "- IDLE: Blue in color."
				state_idle.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				state_idle_update.visible = true
				print("Progress:" + str(progress))
				print("Total States: " + str(total_states))
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_idle.text = "- IDLE: Blue in color, with a hole in their back to spray water."
				state_idle_update.visible = true
				progress += 1
			if times_found == 10:
				state_idle.text = "- IDLE: Blue in color, with rubbery skin and a blowhole."
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
				state_eat.text = "- EAT: Use their long tongues to grab fruit from afar."
				state_eat_update.visible = true
				progress += 1
			if times_found == 10:
				state_eat.text = "- EAT: Their tongue can stretch up to their entire body legnth!"
				state_eat_update.visible = true
				state_eat.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Rest":
			if times_found == 1:
				state_rest.text = "- REST: Takes short naps every so often to restore energy."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_rest.text = "- REST: Sleeps for a long time to recover stamina."
				state_rest_update.visible = true
				progress += 1
			if times_found == 10:
				state_rest.text = "- REST: Rarely sleeps, but takes long naps when worn out."
				state_rest_update.visible = true
				state_rest.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Pet":
			if times_found == 1:
				state_pet.text = "- PET: Their skin is slippery."
				state_pet_update.visible = true
				state_pet.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_pet.text = "- PET: Their slime-covered skin keeps them from drying out."
				state_pet_update.visible = true
				progress += 1
			if times_found == 10:
				state_pet.text = "- PET: Their slime keeps them moist, but the sun still bothers them."
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
				state_poke.text = "- ANNOY: Will puff out their cheeks when poked."
				state_poke_update.visible = true
				progress += 1
			if times_found == 10:
				state_poke.text = "- ANNOY: Will puff their cheeks and spray water to startle foes."
				state_poke_update.visible = true
				state_poke.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Play":
			if times_found == 1:
				state_play.text = "- PLAY: Enjoys spraying water to relieve stress."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_play.text = "- PLAY: Plays by spraying a fountain of water from their back.."
				state_play_update.visible = true
				progress += 1
			if times_found == 10:
				state_play.text = "- PLAY: Plays with anybody by hopping about and spraying water."
				state_play_update.visible = true
				state_play.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Chase":
			if times_found == 1:
				state_chase.text = "- CHASE: Will pursue other creatures when agitated."
				state_chase_update.visible = true
				state_chase.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_chase.text = "- CHASE: When agitated, will puff up and hop after a target."
				state_chase_update.visible = true
				progress += 1
			if times_found == 10:
				state_chase.text = "- CHASE: Hops quickly towards a fight to relieve stress."
				state_chase_update.visible = true
				state_chase.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Attack":
			if times_found == 1:
				state_attack.text = "- ATTACK: Uses their long tongue to fight."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_attack.text = "- ATTACK: Their tongue gives their attacks high range."
				state_attack_update.visible = true
				progress += 1
			if times_found == 10:
				state_attack.text = "- ATTACK: Attacks with a whiplike tongue, striking instantly."
				state_attack_update.visible = true
				state_attack.self_modulate = Color(0.0, 0.5, 0.0, 1.0)
				progress += 1
		"Flee":
			if times_found == 1:
				state_flee.text = "- FLEE: Runs around aimlessly when attacked."
				state_flee_update.visible = true
				state_flee.self_modulate = Color(0.514, 0.314, 0.012, 1.0)
				progress += 1
				found_states_creature += 1
			if times_found == 5:
				state_flee.text = "- FLEE: Will flee attackers, as well as Sonicoo, for some reason."
				state_flee_update.visible = true
				progress += 1
			if times_found == 10:
				state_flee.text = "- FLEE: Will hop about aimlessly to flee attackers or Sonicoo."
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
	
