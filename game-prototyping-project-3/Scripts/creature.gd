extends CharacterBody2D
class_name Creature

# Variables
var creature_name: StringName
@export var type: StringName = "Creature"
var creature_color: Color

@export var hit_points: int = 100
@export var hunger: float = 100
@export var feisty: float = 0
@export var tired: float = 0
@export var move_speed: float = 10

@export var friend_types: Array[StringName]
@export var predator_types: Array[StringName]
@export var prey_types: Array[StringName]

var hunger_scale: float = 1.0
var feisty_scale: float = 1.0
var tired_scale: float = 1.0

# Poison
var is_poisoned: bool = false
var poison_damage_timer: float = 0
var poison_ticks_remaining: int = 0

var detect_radius: Area2D
var eat_radius: Area2D
var state_machine: StateMachine

var time_passed: float = 0

# Dragging
var is_dragging: bool = false

# This should not be necessary!
@export var blackboard: Blackboard

var state_captured: bool = false

# Signals
signal SelectedForCheck
signal SpawnFood
signal Leaving(creature_name: StringName)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detect_radius = $DetectRadius
	eat_radius = $EatRadius
	state_machine = $StateMachine # Very hacky and gross way to allow state access
	
	$StateMachine.connect("state_changed", on_state_changed)
	
	# Random name generation, for funsies
	# creature_name = generate_name()
	creature_name = GameState.creature_names[type].pick_random()
	$NameLabel.text = creature_name
	
	# Randomize appearance
	
	creature_color = Color(randf_range(0.8, 1), randf_range(0.8, 1), randf_range(0.8, 1))
	$Sprite2D.modulate = creature_color
	## SCALE: Removed for the sake of pixel consistency
	# var random_scale = randf_range(0.75, 1.25)
	# $Sprite2D.scale = Vector2(random_scale, random_scale)
	
	# Randomize stat growth rates
	hunger_scale = randf_range(0.75, 1.25)
	feisty_scale = randf_range(0.75, 1.25)
	tired_scale = randf_range(0.75, 1.25)
	
	$Stats/NatureLabel.text = nature_picker()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	# TODO: Make the labels update constantly, if you feel like it
		
	if time_passed > 5:
		# print("Hunger: " + str(hunger))
		# print("Feisty: " + str(feisty))
		# print("Tired: " + str(tired))
		time_passed = 0
	
	# Poison ticks
	if is_poisoned:
		poison_damage_timer -= delta
		if poison_damage_timer <= 0:
			poison_damage()
	
	if (hunger == 0 or hit_points == 0) and not $VisibleOnScreenNotifier2D.is_on_screen() and not blackboard.hidden:
		Leaving.emit(creature_name)
		
		# Remove partner, if applicable
		if blackboard is BlackboardPredator:
			if blackboard.partner:
				blackboard.partner.blackboard.partner = null
		
		# Set checking creature to null, if applicable
		if GameState.selected_creature == self:
			GameState.selected_creature = null
		
		# Erase
		GameState.existing_creatures.erase(self)
		GameState.num_existing_creatures -= 1
		queue_free()
	

func _physics_process(delta: float) -> void:
	# move_and_slide()
	if is_dragging:
		position = get_global_mouse_position()
	
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

var consonants = ["b", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "z"]
var vowels = ["a", "e", "i", "o", "u", "y"]
var banned_words = ["dyke", "kike", "rape", "paki"] # These are slurs or other words that could be generated but should NOT be allowed

func generate_name() -> StringName:
	var final_string = ""
	
	for i in range(randi_range(2, 4)):
		final_string += consonants.pick_random()
		
		final_string += vowels.pick_random()
	
	if final_string in banned_words:
		final_string = "noname"
	final_string = final_string.capitalize()
	return final_string
	
func nature_picker() -> StringName:
	if feisty_scale >= 1.15:
		return "Diva"
	if feisty_scale <= 0.85:
		return "Shy"
	if tired_scale >= 1.15:
		return "Lazy"
	if tired_scale <= 0.85:
		return "Alert"
	if hunger_scale >= 1.15:
		return "Gluttonous"
	if hunger_scale <= 0.85:
		return "Modest"
	return "Average"

# Setters
func change_food(amount: float, scalable: bool) -> void:
	if scalable:
		amount *= hunger_scale
	hunger += amount
	if hunger > 100:
		hunger = 100
	if hunger < 0:
		hunger = 0
	$Stats/HungerMeter.value = hunger

func change_feisty(amount: float, scalable: bool) -> void:
	if scalable:
		amount *= feisty_scale
	feisty += amount
	if feisty > 100:
		feisty = 100
	if feisty < 0:
		feisty = 0
	$Stats/FeistyMeter.value = feisty

func change_tired(amount: float, scalable: bool) -> void:
	if scalable:
		amount *= tired_scale
	tired += amount
	if tired > 100:
		tired = 100
	if tired < 0:
		tired = 0
	$Stats/TiredMeter.value = tired

func change_hit_points(amount: float) -> void:
	hit_points += amount
	if hit_points > 100:
		hit_points = 100
	if hit_points < 0:
		hit_points = 0
	$Stats/HPMeter.value = hit_points

# Getters

func get_type() -> StringName:
	return type

func get_state() -> MonsterState:
	return state_machine.current_state

func get_wants_to_play() -> bool:
	return blackboard.wants_to_play

func get_is_visible() -> bool:
	return $VisibleOnScreenNotifier2D.is_on_screen()
	
func get_food() -> float:
	return hunger

func get_tired() -> float:
	return tired
	
func get_feisty() -> float:
	return feisty
	
func get_hit_points() -> int:
	return hit_points

func on_state_changed(new_state: MonsterState) -> void:
	# Update label to display "simple name" of new state
	$StateLabel.text = new_state.simple_name
	if not GameState.get_state_in_journal(type, new_state.simple_name):
		$StateLabel.modulate = Color(0.8, 0.8, 0.8, 1.0)
	elif GameState.get_state_complete(type, new_state.simple_name):
		$StateLabel.modulate = Color(0.1, 1.0, 0.2, 1.0)
	elif GameState.get_state_found(type, new_state.simple_name):
		$StateLabel.modulate = Color(1.0, 0.8, 0.1, 1.0)
	else:
		$StateLabel.modulate = Color(1.0, 1.0, 1.0, 1.0)
	$Sprite2D.texture = new_state.sprite
	
	# Update state capturable
	state_captured = false

func change_sprite(new_sprite: Texture2D) -> void:
	$Sprite2D.texture = new_sprite

func change_visibility(val: bool) -> void:
	visible = val

func change_label_color(val: Color) -> void:
	$StateLabel.modulate = val

# Way for the player to give a signal to creatures
func send_signal(signal_type: StringName, signal_sender: Node2D) -> void:
	blackboard.signal_type = signal_type
	blackboard.signal_sender = signal_sender
	
func change_stats_visible(value: bool) -> void:
	$Stats.visible = value
	
	# For now, update labels only when first being checked
	if value == true:
		$Stats/HPLabel.text = "HP: " + str(int(hit_points))
		$Stats/HungerLabel.text = "Hunger: " + str(int(hunger))
		$Stats/FeistyLabel.text = "Feisty: " + str(int(feisty))
		$Stats/TiredLabel.text = "Tired: " + str(int(tired))
		
func deal_damage(attacker: Creature, damage: int) -> void:
	change_hit_points(damage * -1)
	blackboard.stunned = true
	blackboard.current_attacker = attacker

func poison_damage() -> void:
	change_hit_points(-10) # TODO: Maybe make this per-creature
	change_tired(5, false)
	if poison_ticks_remaining > 0:
		poison_ticks_remaining -= 1
		poison_damage_timer = 1
	else:
		is_poisoned = false
		toggle_poison_color(false)

func toggle_poison_color(is_poisoned: bool) -> void:
	if is_poisoned:
		$Sprite2D.modulate = Color(1, 0, 1)
	else:
		$Sprite2D.modulate = creature_color
	
# Gross way to do this, should use signals, but for now I don't want to bother
func spawn_food_nearby() -> void:
	SpawnFood.emit(position, 100)

# Input
# Ew ew ew
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		
		print("Pressed")
		
		# Hacky failsafe to ensure switching 
		# TODO: Find a better way to do this so a ceature stops being dragged if the player isn't in drag mode!
		if GameState.mode != GameState.INTERACT_MODES.DRAG:
			is_dragging = false
		
		# Don't register clicks if not visible (except for disengaging dragging)
		if not visible:
			return
			
		if not GameState.in_interact_range and GameState.mode != GameState.INTERACT_MODES.CHECK:
			return
			
		match GameState.mode:
			
			GameState.INTERACT_MODES.CHECK:
				if event.pressed:
					print("Mode is check")
					GameState.selected_creature = self
					SelectedForCheck.emit()
				
			GameState.INTERACT_MODES.PET:
				if event.pressed:
					print("Mode is pet")
					# Prevent petting before three states are found
					if GameState.num_found_states < 1:
						print("Not enough points!")
						return
					
					blackboard.is_pet = true
			
			GameState.INTERACT_MODES.POKE:
				if event.pressed:
					print("Mode is poke")
					# Prevent petting before three states are found
					if GameState.num_found_states < 1:
						print("Not enough points!")
						return
					
					blackboard.is_poked = true
			
			GameState.INTERACT_MODES.DRAG:
				print("Mode is drag")
				is_dragging = event.is_pressed()
			

func _on_detect_radius_area_entered(area: Area2D) -> void:
	if area.is_in_group("food"):
		blackboard.seen_food.append(area)
		return
	
	if area.is_in_group("cover"):
		blackboard.seen_cover.append(area.get_parent())
		return

func _on_detect_radius_area_exited(area: Area2D) -> void:
	if area.is_in_group("food"):
		blackboard.seen_food.erase(area)
		return
	
	if area.is_in_group("cover"):
		blackboard.seen_cover.erase(area.get_parent())
		return
		
func _on_detect_radius_body_entered(body: Node2D) -> void:
	if body == self:
		return
		
	if body.is_in_group("creature"):
		blackboard.seen_creatures.append(body)
		return
	
	if body.is_in_group("player"):
		print("Found player!")
		blackboard.seen_players.append(body)
		return

func _on_detect_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("creature"):
		blackboard.seen_creatures.erase(body)
		return
	
	if body.is_in_group("player"):
		blackboard.seen_players.erase(body)
		return

# For now just handles hiding places
func _on_eat_radius_area_entered(area: Area2D) -> void:
	if area.is_in_group("hiding_place"):
		blackboard.seen_hiding_places.append(area)
		# print(creature_name + " found hiding place")
		return
	
	if area.is_in_group("cover"):
		blackboard.entered_cover += 1
		return


func _on_eat_radius_area_exited(area: Area2D) -> void:
	if area.is_in_group("hiding_place"):
		blackboard.seen_hiding_places.erase(area)
		# print(creature_name + " lost hiding place")
		return
	
	if area.is_in_group("cover"):
		blackboard.entered_cover -= 1
		return
