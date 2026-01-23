extends Node

class_name Transition

@export var conditions: Array[Condition]
@export var actions: Array[Action]
@export var next_state: StringName

signal Transitioned

func evaluate(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> bool:
	for condition in conditions:
		if condition.evaluate(blackboard, owning_creature, owning_state, _delta) == false:
			return false
	
	# Only continue if all conditions return true
	for action in actions:
		action.act(blackboard, owning_creature, owning_state, _delta)
	
	# Transitioned.emit(self, next_state)
	print("Transition success")
	return true
