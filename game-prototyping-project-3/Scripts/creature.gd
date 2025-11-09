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
	# move_and_slide()
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	## Reverse x-value movement if going out of bounds
	#if position.x >= GameState.screen_size.x or position.x <= 0:
		#velocity.x *= -1
	## Reverse y-value movement if going out of bounds
	#if position.y >= GameState.screen_size.y or position.y <= 0:
		#velocity.y *= -1
	
	# This is ugly but it preserves direction when velocity = 0
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	elif velocity.x < 0:
		$Sprite2D.flip_h = false
	# $Sprite2D.flip_h = (velocity.x > 0)
	

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
	if hunger > 100:
		hunger = 100
	if hunger < 0:
		hunger = 0

func change_feisty(amount: float) -> void:
	feisty += amount
	if feisty > 100:
		feisty = 100
	if feisty < 0:
		feisty = 0

func change_tired(amount: float) -> void:
	tired += amount
	if tired > 100:
		tired = 100
	if tired < 0:
		tired = 0

func change_hit_points(amount: float) -> void:
	hit_points += amount
	if hit_points > 100:
		hit_points = 100
	if hit_points < 0:
		hit_points = 0
	
func get_wants_to_play() -> bool:
	return blackboard.wants_to_play

func get_is_visible() -> bool:
	return $VisibleOnScreenNotifier2D.is_on_screen()

func on_state_changed(new_state: State) -> void:
	# Update label to display "simple name" of new state
	$StateLabel.text = new_state.simple_name
	$Sprite2D.texture = new_state.sprite

func change_stats_visible(value: bool) -> void:
	$Stats.visible = value
	
	# For now, update labels only when first being checked
	if value == true:
		$Stats/HPLabel.text = "HP: " + str(hit_points)
		$Stats/HungerLabel.text = "Hunger: " + str(hunger)
		$Stats/FeistyLabel.text = "Feisty: " + str(feisty)
		$Stats/TiredLabel.text = "Tired: " + str(tired)
		
func deal_damage(attacker: Creature, damage: int) -> void:
	change_hit_points(damage * -1)
	blackboard.stunned = true
	blackboard.current_attacker = attacker

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
		
	


func _on_detect_radius_area_exited(area: Area2D) -> void:
	if area.is_in_group("food"):
		blackboard.seen_food.erase(area)
		return
		

func _on_detect_radius_body_entered(body: Node2D) -> void:
	if body == self:
		return
		
	if body.is_in_group("creature"):
		blackboard.seen_creatures.append(body)
		return


func _on_detect_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("creature"):
		blackboard.seen_creatures.erase(body)
		return
