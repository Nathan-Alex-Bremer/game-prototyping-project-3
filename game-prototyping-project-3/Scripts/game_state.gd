extends Node2D

# Creatures
var num_existing_creatures = 5
@export var max_creatures: int = 5
@export var creature_scene: PackedScene
@export var predator_scene: PackedScene


var existing_creatures: Array[Creature]
var selected_creature: Creature

# Food
var num_food: int = 0
@export var max_food: int = 10
@export var food_scene: PackedScene

# Player
@export var player_scene: PackedScene
var player_in_journal: bool = false

var screen_size: Vector2

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
	POKE
}
var mode = INTERACT_MODES.CHECK

# MonsterStates
var found_states = {
	"Creature" = {},
	"Predator" = {}
}

var num_found_states: int = 0




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
	
	found_states["Predator"]["Eat"] = 0
	found_states["Predator"]["Idle"] = 0
	found_states["Predator"]["Wander"] = 0
	found_states["Predator"]["Rest"] = 0
	found_states["Predator"]["Pet"] = 0
	found_states["Predator"]["Annoyed"] = 0
	found_states["Predator"]["Play"] = 0
	found_states["Predator"]["Chase"] = 0
	found_states["Predator"]["Attack"] = 0
	found_states["Predator"]["Flee"] = 0
