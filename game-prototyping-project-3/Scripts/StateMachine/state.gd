extends Node
class_name State

@export var simple_name: StringName = ""
@export var blackboard: Blackboard
@export var owning_creature: Creature

# Useful variables
# var move_direction: Vector2

# Signals
signal Transitioned

# Actions
func enter() -> void:
	pass
	
func exit() -> void:
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
