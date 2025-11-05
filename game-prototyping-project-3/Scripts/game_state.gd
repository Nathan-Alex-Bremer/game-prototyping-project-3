extends Node2D

# Creatures
var num_creatures: int = 0
@export var max_creatures: int = 10
@export var creature_scene: PackedScene

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

# States
var found_states = {}
var num_found_states: int = 0




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	screen_size = get_viewport_rect().size
	
	# TODO: Make this cleaner
	found_states["creaturestateeat"] = false
	found_states["creaturestateidle"] = false
	found_states["creaturestatewander"] = false
	found_states["creaturestatemovetofood"] = false
	found_states["creaturestaterest"] = false
