class_name Blackboard
extends Node

# Variables
@export var state_machine: StateMachine
@export var creature: CharacterBody2D

# Time
var state_time_elapsed: float
var update_delta: float
var physics_update_delta: float

func increment_state_time(_delta: float):
	state_time_elapsed += _delta

func reset_state_time():
	state_time_elapsed = 0

func check_if_state_time_elapsed(duration: float) -> bool:
	if state_time_elapsed >= duration:
		return true
	return false

# Movement

var move_speed: float = 10

var move_direction: Vector2
var wander_time: float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1))
	wander_time = randf_range(1, 3)

# Perception

var perception_radius: float

func find_target_in_radius(target_group: StringName):
	if not creature:
		return
	
	for body in creature.get_node("DetectRadius").get_overlapping_bodies():
		if body.is_in_group(target_group):
			return body
