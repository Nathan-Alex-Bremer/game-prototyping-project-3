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
	player.connect("ChangeJournalPage", on_change_journal_page)
	player.connect("ChangeMode", on_change_mode)
	player.connect("ToggleCreatureStats", on_toggle_creature_stats)
	add_child(player)
	
	# Instantiate a creature
	for i in range(GameState.max_creatures):
		var new_creature = GameState.creature_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_creature.position = random_point
		new_creature.connect("SelectedForCheck", on_creature_selected_check)
		new_creature.connect("Leaving", on_creature_leaving)
		add_child(new_creature)
		GameState.existing_creatures.append(new_creature)
	for i in range(1):
		var new_creature = GameState.predator_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_creature.position = random_point
		new_creature.connect("SelectedForCheck", on_creature_selected_check)
		new_creature.connect("Leaving", on_creature_leaving)
		add_child(new_creature)
		GameState.existing_creatures.append(new_creature)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	
	if timer <= 0:
		# TODO: Add check for max food amount here
		spawn_food()
		
		if randi_range(1, 5) == 5 and GameState.num_existing_creatures < GameState.max_creatures:
			spawn_creature()
		# Reset timer
		timer = timer_count

func spawn_food() -> void:
	var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
	
	# Instantiate food object
	var new_food = GameState.food_scene.instantiate()
	new_food.position = random_point
	add_child(new_food)

func spawn_creature() -> void:
	var new_creature
	if randi_range(1, 5) == 1:
		new_creature = GameState.predator_scene.instantiate()
	else:
		new_creature = GameState.creature_scene.instantiate()
	var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
	new_creature.position = random_point
	new_creature.connect("SelectedForCheck", on_creature_selected_check)
	new_creature.connect("Leaving", on_creature_leaving)
	add_child(new_creature)
	GameState.existing_creatures.append(new_creature)
	GameState.num_existing_creatures += 1
	player.creature_joined(new_creature.creature_name)

func on_capture_state(creature_type: StringName, state: StringName) -> void:
	for known_state in GameState.found_states[creature_type]:
		if known_state == state:
			if GameState.found_states[creature_type][state] == 0:
				GameState.num_found_states += 1
				found_states_updated()
			GameState.found_states[creature_type][state] += 1
			print("Found State: " + state)
			
			player.on_state_found(creature_type, state, GameState.found_states[creature_type][state])
			return

func found_states_updated() -> void:
	GameState.max_creatures = 5 + int(GameState.num_found_states / 2)
	
	match GameState.num_found_states:
		2:
			player.interact_mode_unlocked("Place Food")
		4:
			player.interact_mode_unlocked("Pet")
		6:
			player.interact_mode_unlocked("Poke")

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
	player.open_journal() # Why does this go through BaseScene
	
func on_change_journal_page(forward: bool) -> void:
	player.change_journal_page(forward) # Why does this go through BaseScene
	
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

func on_creature_leaving(creature_name: StringName) -> void:
	player.creature_left(creature_name)
