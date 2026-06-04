extends Node2D

# Controls debug testing things!
var debug_on: bool = false

# Scene
var main_scene: Node
var current_scene: Node

var player_node: Node
var options_menu_node: Node # So I don't have to  redo eeeeverything, I have to pull some real nonsense - sorry

# Player interact options!
var in_interact_range: bool = true

# Settings
var high_contrast_mode: bool = false
var bright_mode: bool = false
var dyslexic_mode: bool = false
var flash_disabled: bool = false

# Interact modes
var check_unlocked: bool = true 
var place_food_unlocked: bool = false
var pet_unlocked: bool = false
var poke_unlocked: bool = false
var drag_unlocked: bool = false
var horn_unlocked: bool = false

# Creatures
var num_existing_creatures = 5
@export var max_creatures: int = 5
@export var creature_scene: PackedScene
@export var predator_scene: PackedScene
@export var plantcreature_scene: PackedScene
@export var frog_scene: PackedScene
@export var moth_scene: PackedScene
@export var bird_scene: PackedScene
@export var boss_scene: PackedScene
@export var tutorialcreature_scene: PackedScene


var existing_creatures: Array[Creature]
var selected_creature: Creature

# Environment
var raining: bool = false


# Food
var num_food: int = 0
@export var max_food: int = 10
var player_food_store: int = 10
@export var player_max_food_store: int = 10
@export var food_scene: PackedScene


var num_creatures_discovered: int = 0

# Hiding places
@export var bush_scene: PackedScene
@export var tree_scene: PackedScene
@export var flowers_scene: PackedScene
@export var raindrop_scene: PackedScene

# Player
@export var player_scene: PackedScene
@export var options_menu_scene: PackedScene
var input_allowed: bool = true
var player_in_journal: bool = false
var player_in_quest_menu: bool = false
var dialogue_open: bool = false
@export var camera_area_scene: PackedScene

var screen_size: Vector2

# Progress
var completed_quests: int = 0
var has_horn: bool = false
var horn_sounded: bool = false # Handles "final boss" incoming
var boss_ever_summoned: bool = false # Handles first-time boss behavior
var boss_active: bool = false

# Options (since can't do anything while paused)
var dyslexic_mode_queued: bool = false
var dyslexic_mode_val: bool = false

var high_contrast_mode_queued: bool = false
var high_contrast_mode_val: bool = false

#enum STATES {
	#IDLE,
	#WANDER,
	#MOVE_TO_FOOD,
	#EAT,
	#REST
#}

enum INTERACT_MODES {
	CHECK,
	PLACE_FOOD,
	PET,
	POKE,
	DRAG,
	HORN
}
var mode = INTERACT_MODES.CHECK

# MonsterStates
var found_states = {
	"Creature" = {},
	"Predator" = {},
	"PlantCreature" = {},
	"Bird" = {},
	"Frog" = {},
	"Moth" = {},
	"Boss" = {},
	"Reference" = {} # I think the game might freak out here otherwise
}

var num_found_states: int = 0

# Creature Names
# Loading in files and names
var names_creature_file: NameList = load("res://Text/creature_names.tres")
var names_creature = names_creature_file.names

var names_predator_file: NameList = load("res://Text/predator_names.tres")
var names_predator = names_predator_file.names

var names_plantcreature_file: NameList = load("res://Text/plantcreature_names.tres")
var names_plantcreature = names_plantcreature_file.names

var names_bird_file: NameList = load("res://Text/bird_names.tres")
var names_bird = names_bird_file.names

var names_frog_file: NameList = load("res://Text/frog_names.tres")
var names_frog = names_frog_file.names

var names_moth_file: NameList = load("res://Text/moth_names.tres")
var names_moth = names_moth_file.names

var names_tutorialcreature_file: NameList = load("res://Text/testcreature_names.tres")
var names_tutorialcreature = names_tutorialcreature_file.names

var names_boss_file: NameList = load("res://Text/boss_names.tres")
var names_boss = names_boss_file.names

var creature_names = {"Creature" = names_creature,
			"Predator" = names_predator,
			"PlantCreature" = names_plantcreature,
			"Bird" = names_bird,
			"Frog" = names_frog,
			"Moth" = names_moth,
			"Boss" = names_boss,
			"TutorialCreature" = names_tutorialcreature
			}
			

# Tutorial

# Whether to use tutorial mode/restrict things
var tutorial_mode: bool = false

# Keep track of tutorial steps
var tutorial_checks: Array = ["Move", "Check", "Picture", "Journal", "Complete"]
var tutorial_stage: int = 0

# Tutorial data
var tutorial_found_states = {
	"TutorialCreature" = {
		"Idle" = 0
	}
}

## FUNCTIONS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	
	# TODO: Make this cleaner
	found_states["Creature"]["Eat"] = 0
	found_states["Creature"]["Idle"] = 0
	found_states["Creature"]["Wander"] = 0
	found_states["Creature"]["Rest"] = 0
	found_states["Creature"]["Pet"] = 0
	found_states["Creature"]["Annoyed"] = 0
	found_states["Creature"]["Play"] = 0
	found_states["Creature"]["Digt"] = 0
	found_states["Creature"]["Attack"] = 0
	found_states["Creature"]["Flee"] = 0
	
	found_states["Predator"]["Attack Eat"] = 0
	found_states["Predator"]["Idle"] = 0
	found_states["Predator"]["Wander"] = 0
	found_states["Predator"]["Rest"] = 0
	found_states["Predator"]["Pet"] = 0
	found_states["Predator"]["Annoyed"] = 0
	found_states["Predator"]["Play"] = 0
	found_states["Predator"]["Eat"] = 0
	found_states["Predator"]["Attack"] = 0
	found_states["Predator"]["Intimidate"] = 0
	
	found_states["PlantCreature"]["Photosynthesize"] = 0
	found_states["PlantCreature"]["Idle"] = 0
	found_states["PlantCreature"]["Wander"] = 0
	found_states["PlantCreature"]["Rest"] = 0
	found_states["PlantCreature"]["Pet"] = 0
	found_states["PlantCreature"]["Annoyed"] = 0
	found_states["PlantCreature"]["Play"] = 0
	found_states["PlantCreature"]["Drop Food"] = 0
	found_states["PlantCreature"]["Poison Dust"] = 0
	found_states["PlantCreature"]["Flee"] = 0
	
	found_states["Bird"]["Eat"] = 0
	found_states["Bird"]["Idle"] = 0
	found_states["Bird"]["Wander"] = 0
	found_states["Bird"]["Rest"] = 0
	found_states["Bird"]["Pet"] = 0
	found_states["Bird"]["Annoyed"] = 0
	found_states["Bird"]["Play"] = 0
	found_states["Bird"]["Chase"] = 0
	found_states["Bird"]["Attack"] = 0
	found_states["Bird"]["Flee"] = 0
	
	found_states["Frog"]["Eat"] = 0
	found_states["Frog"]["Idle"] = 0
	found_states["Frog"]["Wander"] = 0
	found_states["Frog"]["Rest"] = 0
	found_states["Frog"]["Pet"] = 0
	found_states["Frog"]["Annoyed"] = 0
	found_states["Frog"]["Play"] = 0
	found_states["Frog"]["Spray"] = 0
	found_states["Frog"]["Attack"] = 0
	found_states["Frog"]["Flee"] = 0
	
	found_states["Moth"]["Eat"] = 0
	found_states["Moth"]["Idle"] = 0
	found_states["Moth"]["Wander"] = 0
	found_states["Moth"]["Pollinate"] = 0
	found_states["Moth"]["Pet"] = 0
	found_states["Moth"]["Annoyed"] = 0
	found_states["Moth"]["Play"] = 0
	found_states["Moth"]["Spread Pollen"] = 0
	found_states["Moth"]["Attack"] = 0
	found_states["Moth"]["Flee"] = 0
	
	found_states["Boss"]["Idle"] = 0
	found_states["Boss"]["Wander"] = 0
	found_states["Boss"]["Rest"] = 0
	found_states["Boss"]["Pet"] = 0
	found_states["Boss"]["Alerted"] = 0
	found_states["Boss"]["Play"] = 0
	found_states["Boss"]["Eat"] = 0
	found_states["Boss"]["Attack"] = 0
	found_states["Boss"]["Attack Eat"] = 0
	found_states["Boss"]["Chase"] = 0

func reset_state() -> void:
	for creature in found_states:
		for state in found_states[creature]:
			found_states[creature][state] = 0
	
	tutorial_found_states["TutorialCreature"]["Idle"] = 0
	
	num_found_states = 0
	
	place_food_unlocked = false
	pet_unlocked = false
	poke_unlocked = false
	drag_unlocked = false
	horn_unlocked = false
	mode = INTERACT_MODES.CHECK
	
	num_existing_creatures = 5
	max_creatures = 5
	
	num_food = 0
	
	tutorial_stage = 0
	
	player_node.reset_state()
	
	
func get_state_in_journal(creature_name: StringName, state_name: StringName) -> bool:
	if tutorial_mode:
		return tutorial_found_states[creature_name].has(state_name)
		
	return (found_states[creature_name].has(state_name))
	
func get_state_found(creature_name: StringName, state_name: StringName) -> bool:
	if tutorial_mode:
		return tutorial_found_states[creature_name][state_name] > 0
		
	return (found_states[creature_name][state_name] > 0)
	
func get_state_complete(creature_name: StringName, state_name: StringName) -> bool:
	if tutorial_mode:
		return tutorial_found_states[creature_name][state_name] > 10
		
	return (found_states[creature_name][state_name] >= 10)

func unlock_horn() -> void: # Ugly way to do this
	has_horn = true
	horn_unlocked = true
	player_node.interact_mode_unlocked(INTERACT_MODES.HORN)

func update_tutorial(stage: int) -> bool:
	print("Current stage: " + str(tutorial_stage))
	print("Next stage: " + str(stage))
	if stage == (tutorial_stage + 1):
		tutorial_stage = stage
		return true
	
	print("ERROR: Tutorial completed out of order!")
	return false

var main_menu_scene = preload("res://Scenes/main_menu_scene.tscn")
var tutorial_scene = preload("res://Scenes/TutorialScene.tscn")
var base_scene = preload("res://Scenes/BaseScene.tscn")

func set_initial_scene() -> void:
	if main_scene:
		current_scene = main_menu_scene.instantiate()
		main_scene.add_child(current_scene)
		player_node.reparent(current_scene)
		options_menu_node.reparent(current_scene)
	else:
		print("ERROR: Main scene not loaded!")

func change_scene(new_scene_name: String) -> void:	
	# Unload old scene
	# get_tree().root.remove_child(current_scene)
	# Remove remaining other references in GameState
	existing_creatures.clear()
	selected_creature = null
	
	# To avoid player node being unloaded
	player_node.reparent(main_scene)
	options_menu_node.reparent(main_scene)
	
	# Load in new scene
	var new_scene: Node
	match new_scene_name:
		"TutorialScene":
			new_scene = tutorial_scene.instantiate()
			main_scene.call_deferred("add_child", new_scene)
			# main_scene.add_child(new_scene)
		"BaseScene":
			new_scene = base_scene.instantiate()
			main_scene.call_deferred("add_child", new_scene)
			# main_scene.add_child(new_scene)
		"main_menu_scene":
			reset_state() # TODO: Does this work
			new_scene = main_menu_scene.instantiate()
			main_scene.call_deferred("add_child", new_scene)
			# main_scene.add_child(new_scene)
		_:
			print("ERROR: UNKNOWN SCENE")
			return
	
	# Remove old scene
	current_scene.queue_free()
	
	# Update current scene
	current_scene = new_scene
	player_node.reparent(new_scene)
	
	# I would like to formally apologize for this
	# I swear next time I'll take the time to set up my UI properly so I don't need to do THIS
	if new_scene_name == "main_menu_scene":
		options_menu_node.reparent(new_scene)
	else:
		options_menu_node.reparent(player_node)

func open_options_menu() -> void:
	options_menu_node.show_menu()
	# current_scene.set_process_input(false)

func close_options_menu() -> void:
	options_menu_node.hide_menu()
	# current_scene.set_process_input(true)
	
func update_interact_mode(new_mode: INTERACT_MODES):
	mode = new_mode
	player_node.update_interact_highlights(new_mode)
	
func on_unpause() -> void:
	print("Game State: On Unpause")
	if dyslexic_mode_queued:
		dyslexic_mode = dyslexic_mode_val
		toggle_dyslexic_mode(dyslexic_mode_val)
		dyslexic_mode_queued = false
	if high_contrast_mode_queued:
		high_contrast_mode = high_contrast_mode_val
		toggle_high_contrast(high_contrast_mode_val)
		high_contrast_mode_queued = false

func toggle_dyslexic_mode(val: bool) -> void:
	print("Game State: Toggle Dyslexic Mode")
	var dyslexic_font = load("res://Fonts/OpenDyslexic-Regular.otf")
	var regular_font = load("res://Fonts/lazy_dog.ttf")
	var tooltip_label_settings: LabelSettings = load("res://Scenes/Quest/InteractModeTooltip.tres")
	
	player_node.toggle_dyslexic_mode(val)
	current_scene.toggle_dyslexic_mode(val)
	
	# Handling tooltip
	# TODO: Handle this more elegantly
	if val:
		tooltip_label_settings.font = dyslexic_font
		tooltip_label_settings.font_size -= 8
	else:
		tooltip_label_settings.font = regular_font
		tooltip_label_settings.font_size += 8
	
	
func edit_bgm_volume(val: float) -> void:
	# Hacky "mute"
	if val == 0.01:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear_to_db(0.0001))
		return
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BGM"), linear_to_db(val))
	
func edit_sfx_volume(val: float) -> void:
	if val == 0.01:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("World SFX"), linear_to_db(0.0001))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Proximity SFX"), linear_to_db(0.0001))
		return
		
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("World SFX"), linear_to_db(val))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Proximity SFX"), linear_to_db(val+0.2))

var contrast_shader = load("res://Scenes/Contrast.gdshader")
var gamma_shader = load("res://Scripts/Gamma.gdshader")

func toggle_high_contrast(val: bool) -> void:
	# player_node.toggle_high_contrast(val)
	main_scene.toggle_high_contrast(val)
	
