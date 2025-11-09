extends Node2D

# @export var player: PlayerObserver

@export var timer_count: float = 10
var timer: float

var player: PlayerObserver

# State changing
var interact_mode_text: StringName = "Current Interact Mode: "

signal journal_opened

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	timer = timer_count
	
	# Instantiate a player observer
	player = GameState.player_scene.instantiate()
	player.connect("CapturedState", on_capture_state)
	player.connect("ClickedFood", on_clicked_food)
	player.connect("OpenJournal", on_open_journal)
	player.connect("ChangeMode", on_change_mode)
	player.connect("ToggleCreatureStats", on_toggle_creature_stats)
	add_child(player)
	
	# Instantiate a creature
	for i in range(10):
		var new_creature = GameState.creature_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
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
	var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
	
	# Instantiate food object
	var new_food = GameState.food_scene.instantiate()
	new_food.position = random_point
	add_child(new_food)

func on_capture_state(state: StringName) -> void:
	for known_state in GameState.found_states:
		if known_state == state:
			if GameState.found_states[state] == 0:
				GameState.num_found_states += 1
			GameState.found_states[state] += 1
			print("Found State: " + state)
			
			player.on_state_found(state, GameState.found_states[state])
			return

func on_clicked_food(food_position: Vector2) -> void:
	if GameState.num_found_states < 1:
		print("Not enough research done!")
		return
		
	# Instantiate food object
	# var place_for_food = get_viewport().get_mouse_position()
	var new_food = GameState.food_scene.instantiate()
	new_food.position = food_position
	add_child(new_food)

#func _input(event):
	#if event is InputEventMouseButton:
		#if GameState.mode == GameState.INTERACT_MODES.PLACE_FOOD:
			#var new_food = GameState.food_scene.instantiate()
			#new_food.position = event.position
			#add_child(new_food)

func on_open_journal() -> void:
	player.open_journal()
	
func on_change_mode(mode: int) -> void:
	player.change_mode(mode)

func on_toggle_creature_stats() -> void:
	toggle_creature_stats()
	
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
