extends Node2D

# Creatures
var num_creatures: int = 0
@export var max_creatures: int = 10
@export var creature_scene: PackedScene

var existing_creatures: Array[Creature]
var selected_creature: Creature

# Food
var num_food: int = 0
@export var max_food: int = 10
@export var food_scene: PackedScene

# Player
@export var player_scene: PackedScene

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

# States
var found_states = {}
var num_found_states: int = 0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	screen_size = get_viewport_rect().size
	
	# TODO: Make this cleaner
	found_states["Eat"] = 0
	found_states["Idle"] = 0
	found_states["Wander"] = 0
	found_states["Rest"] = 0
	found_states["Pet"] = 0
	found_states["Annoyed"] = 0
	found_states["Play"] = 0
	found_states["Chase"] = 0
	found_states["Attack"] = 0
	found_states["Flee"] = 0
