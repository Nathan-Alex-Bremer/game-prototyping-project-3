extends Node

class_name MonsterState

@export var simple_name: StringName = ""
@export var blackboard: Blackboard
@export var owning_creature: Creature
@export var sprite: Texture2D

# Actions and Transitions
@export var enter_actions: Array[Action]
@export var exit_actions: Array[Action]
@export var update_actions: Array[Action]
@export var physics_update_actions: Array[Action]
@export var transitions: Array[Transition]

# Useful variables
# var move_direction: Vector2

# Signals
signal Transitioned

# Actions
func enter() -> void:
	for action in enter_actions:
		action.act(blackboard, owning_creature, self, 0)
	
func exit() -> void:
	for action in exit_actions:
		action.act(blackboard, owning_creature, self, 0)

func update(_delta: float):
	for action in update_actions:
		action.act(blackboard, owning_creature, self, _delta)

func physics_update(_delta: float):
	for action in physics_update_actions:
		action.act(blackboard, owning_creature, self, _delta)

func check_transitions():
	for transition in transitions:
		if transition.evaluate(blackboard, owning_creature, self, 0):
			return transition.next_state
	return null
