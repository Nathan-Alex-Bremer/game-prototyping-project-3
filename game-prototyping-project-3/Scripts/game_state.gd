extends Node2D

# Controls debug testing things!
var debug_on: bool = true

# Scene
var main_scene: Node
var current_scene: Node

var player_node: Node

# Player interact options!
var in_interact_range: bool = true

# Creatures
var num_existing_creatures = 6
@export var max_creatures: int = 6
@export var creature_scene: PackedScene
@export var predator_scene: PackedScene
@export var plantcreature_scene: PackedScene
@export var frog_scene: PackedScene
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
@export var food_scene: PackedScene

# Hiding places
@export var bush_scene: PackedScene
@export var tree_scene: PackedScene

# Player
@export var player_scene: PackedScene
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

var names_tutorialcreature_file: NameList = load("res://Text/testcreature_names.tres")
var names_tutorialcreature = names_tutorialcreature_file.names

var names_boss_file: NameList = load("res://Text/boss_names.tres")
var names_boss = names_boss_file.names

var creature_names = {"Creature" = names_creature,
			"Predator" = names_predator,
			"PlantCreature" = names_plantcreature,
			"Bird" = names_bird,
			"Frog" = names_frog,
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
	pass # Replace with function body.
	screen_size = get_viewport_rect().size
	
	# TODO: Make this cleaner
	found_states["Creature"]["Eat"] = 0
	found_states["Creature"]["Idle"] = 0
	found_states["Creature"]["Wander"] = 0
	found_states["Creature"]["Rest"] = 0
	found_states["Creature"]["Pet"] = 0
	found_states["Creature"]["Annoyed"] = 0
	found_states["Creature"]["Play"] = 0
	found_states["Creature"]["Chase"] = 0
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
	found_states["Frog"]["Chase"] = 0
	found_states["Frog"]["Attack"] = 0
	found_states["Frog"]["Flee"] = 0
	
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
	player_node.interact_mode_unlocked("Ancient Horn")

func update_tutorial(stage: int) -> bool:
	print("Current stage: " + str(tutorial_stage))
	print("Next stage: " + str(stage))
	if stage == (tutorial_stage + 1):
		tutorial_stage = stage
		return true
	
	print("ERROR: Tutorial completed out of order!")
	return false

var tutorial_scene = preload("res://Scenes/TutorialScene.tscn")
var base_scene = preload("res://Scenes/BaseScene.tscn")

func set_initial_scene() -> void:
	if main_scene:
		current_scene = tutorial_scene.instantiate()
		main_scene.add_child(current_scene)
	else:
		print("ERROR: Main scene not loaded!")

func change_scene(new_scene_name: String) -> void:	
	# Unload old scene
	# get_tree().root.remove_child(current_scene)
	# Remove remaining other references in GameState
	existing_creatures.clear()
	selected_creature = null
	
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
		_:
			print("ERROR: UNKNOWN SCENE")
			return
	
	# Remove old scene
	current_scene.queue_free()
	
	# Update current scene
	current_scene = new_scene
	
	
