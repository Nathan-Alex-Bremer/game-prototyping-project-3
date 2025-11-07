extends Node2D

# @export var player: PlayerObserver

@export var timer_count: float = 60
var timer: float

# State changing
var interact_mode_text: StringName = "Current Interact Mode: "

signal journal_opened

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	timer = timer_count
	
	# Instantiate a player observer
	var new_player = GameState.player_scene.instantiate()
	new_player.connect("CapturedState", on_capture_state)
	new_player.connect("ClickedFood", on_clicked_food)
	new_player.connect("OpenJournal", on_open_journal)
	new_player.connect("ChangeMode", on_change_mode)
	add_child(new_player)
	
	# Instantiate a creature
	for i in range(2):
		var new_creature = GameState.creature_scene.instantiate()
		var random_point = Vector2(randf_range(0, GameState.screen_size.x), randf_range(0, GameState.screen_size.y))
		new_creature.position = random_point
		new_creature.connect("SelectedForCheck", on_creature_selected_check)
		add_child(new_creature)
		GameState.existing_creatures.append(new_creature)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	
	if timer <= 0:
		# TODO: Add check for max food amount here
		spawn_food()
		# Reset timer
		timer = timer_count

func spawn_food() -> void:
	var random_point = Vector2(randf_range(0, GameState.screen_size.x), randf_range(0, GameState.screen_size.y))
	
	# Instantiate food object
	var new_food = GameState.food_scene.instantiate()
	new_food.position = random_point
	add_child(new_food)

func on_capture_state(state: StringName) -> void:
	for known_state in GameState.found_states:
		if known_state == state and GameState.found_states[state] == false:
			GameState.found_states[state] = true
			print("Found State: " + state)
			GameState.num_found_states += 1
			$Journal.on_state_found(state)
			return

func on_clicked_food(food_position: Vector2) -> void:
	if GameState.num_found_states < 1:
		print("Not enough research done!")
		return
		
	# Instantiate food object
	var new_food = GameState.food_scene.instantiate()
	new_food.position = food_position
	add_child(new_food)

func on_open_journal() -> void:
	$Journal.toggle_opened()
	
func on_change_mode(mode: int) -> void:
	match mode:
		GameState.INTERACT_MODES.CHECK:
			$InteractModeLabel.text = interact_mode_text + "Check"
		GameState.INTERACT_MODES.PLACE_FOOD:
			# Since this is the state after Check, for now we disable visible stats here
			GameState.selected_creature = null
			toggle_creature_stats()
			$InteractModeLabel.text = interact_mode_text + "Place Food"
		GameState.INTERACT_MODES.PET:
			$InteractModeLabel.text = interact_mode_text + "Pet"
		GameState.INTERACT_MODES.POKE:
			$InteractModeLabel.text = interact_mode_text + "Poke"
		
# Toggles the visibility of all creature stats off except for the currently selected creature
# When transitioning out of Check action mode, this should be ALL creatures
func toggle_creature_stats() -> void:
	for creature in GameState.existing_creatures:
		if GameState.selected_creature and creature == GameState.selected_creature:
			creature.change_stats_visible(true)
		else:
			creature.change_stats_visible(false)
		
func on_creature_selected_check() -> void:
	toggle_creature_stats()
