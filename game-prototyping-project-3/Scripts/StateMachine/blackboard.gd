extends Node
class_name Blackboard

# Impromptu blackboad to hold information between states
# For the record: this is handled super awkwardly!
# Really it could/should just be a Resource

# Arrays to hold stuff
# Kind of awkward but better than checking for overlapping bodies every frame
var seen_food: Array[Food]
var seen_creatures: Array[Creature]

# Waiting
var wait_time: float = 0

# Targeting (food/creature)
var current_target: Node2D

# Pet tracking
var is_pet: bool = false
var is_poked: bool = false

# Play
var wants_to_play: bool = false

# Fighting
var aggressive: bool = false
var current_attacker: Creature
var stunned: bool = false

# Signal
var signal_type: StringName
var signal_sender: Node2D
