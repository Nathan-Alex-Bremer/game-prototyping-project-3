extends CharacterBody2D
class_name Creature

# Variables
@export var hit_points: int = 100
@export var hunger: float = 100
@export var feisty: float = 0
@export var tired: float = 0
@export var move_speed: float = 10

var detect_radius = Area2D
var eat_radius = Area2D

var time_passed: float = 0

# This should not be necessary!
@export var blackboard: Blackboard

# Signals
signal SelectedForCheck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detect_radius = $DetectRadius
	eat_radius = $EatRadius
	
	$StateMachine.connect("state_changed", on_state_changed)
	
	# Random name generation, for funsies
	$NameLabel.text = generate_name()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	# TODO: Make the labels update constantly, if you feel like it
		
	if time_passed > 5:
		print("Hunger: " + str(hunger))
		print("Feisty: " + str(feisty))
		print("Tired: " + str(tired))
		time_passed = 0
	

func _physics_process(delta: float) -> void:
	move_and_slide()
	

# Custom functions

# Name generation

var consonants = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "z"]
var vowels = ["a", "e", "i", "o", "u", "y"]

func generate_name() -> StringName:
	var final_string = ""
	
	for i in range(randi_range(2, 4)):
		final_string += consonants.pick_random()
		
		final_string += vowels.pick_random()
	
	return final_string

# Setters
func change_food(amount: float) -> void:
	hunger += amount

func change_feisty(amount: float) -> void:
	feisty += amount

func change_tired(amount: float) -> void:
	tired += amount

func on_state_changed(new_state: State) -> void:
	# Update label to display "simple name" of new state
	$StateLabel.text = new_state.simple_name

func change_stats_visible(value: bool) -> void:
	$Stats.visible = value
	
	# For now, update labels only when first being checked
	if value == true:
		$Stats/HPLabel.text = "HP: " + str(hit_points)
		$Stats/HungerLabel.text = "Hunger: " + str(hunger)
		$Stats/FeistyLabel.text = "Feisty: " + str(feisty)
		$Stats/TiredLabel.text = "Tired: " + str(tired)

# Input
# Ew ew ew
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Pressed")
		
		if GameState.mode == GameState.INTERACT_MODES.CHECK:
			print("Mode is check")
			GameState.selected_creature = self
			SelectedForCheck.emit()
			
		if GameState.mode == GameState.INTERACT_MODES.PET:
			print("Mode is pet")
			# Prevent petting before three states are found
			if GameState.num_found_states < 1:
				print("Not enough points!")
				return
			
			blackboard.is_pet = true
		
		if GameState.mode == GameState.INTERACT_MODES.POKE:
			print("Mode is poke")
			# Prevent petting before three states are found
			if GameState.num_found_states < 1:
				print("Not enough points!")
				return
			
			blackboard.is_poked = true


func _on_detect_radius_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		blackboard.seen_food.append(area)
		return
		
	if area.is_in_group("creature"):
		blackboard.seen_creatures.append(area)
		return


func _on_detect_radius_area_exited(area: Area2D) -> void:
	if area.is_in_group("food"):
		blackboard.seen_food.erase(area)
		return
		
	if area.is_in_group("creature"):
		blackboard.seen_creatures.erase(area)
		return
