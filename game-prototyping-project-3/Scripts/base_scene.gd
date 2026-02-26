extends Node2D

# @export var player: PlayerObserver

@export var timer_count: float = 10
var timer: float

var player: PlayerObserver
var camera_area: CameraArea

var next_creature_type: StringName = ""

# State changing
var interact_mode_text: StringName = "Current Interact Mode: "

signal journal_opened

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	timer = timer_count
	
	# Instantiate a player observer
	#camera_area = GameState.camera_area_scene.instantiate()
	#add_child(camera_area)
	
	player = GameState.player_scene.instantiate()
	player.connect("CapturedState", on_capture_state)
	player.connect("ClickedFood", on_clicked_food)
	player.connect("OpenJournal", on_open_journal)
	player.connect("ChangeJournalPage", on_change_journal_page)
	player.connect("ChangeMode", on_change_mode)
	player.connect("ToggleCreatureStats", on_toggle_creature_stats)
	# player.connect_camera_area(camera_area)
	add_child(player)
	
	# Instantiate a creature
	for i in range(GameState.max_creatures - 2):
		var new_creature = GameState.creature_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_creature.position = random_point
		new_creature.connect("SelectedForCheck", on_creature_selected_check)
		new_creature.connect("SpawnFood", spawn_food_near_position)
		new_creature.connect("Leaving", on_creature_leaving)
		add_child(new_creature)
		GameState.existing_creatures.append(new_creature)
	for i in range(1):
		var new_creature = GameState.frog_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_creature.position = random_point
		new_creature.connect("SelectedForCheck", on_creature_selected_check)
		new_creature.connect("Leaving", on_creature_leaving)
		add_child(new_creature)
		GameState.existing_creatures.append(new_creature)
	if GameState.debug_on:
		for i in range(1):
			var new_creature = GameState.bird_scene.instantiate()
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
		for i in range(1):
			var new_creature = GameState.plantcreature_scene.instantiate()
			var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
			new_creature.position = random_point
			new_creature.connect("SelectedForCheck", on_creature_selected_check)
			new_creature.connect("SpawnFood", spawn_food_near_position)
			new_creature.connect("Leaving", on_creature_leaving)
			add_child(new_creature)
			GameState.existing_creatures.append(new_creature)
	
	for i in range(5):
		var new_bush = GameState.bush_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_bush.position = random_point
		add_child(new_bush)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	
	if timer <= 0:
		# TODO: Add check for max food amount here
		if randi_range(1, 3) == 3:
			spawn_food()
		
		if randi_range(1, 5) == 5 and GameState.num_existing_creatures < GameState.max_creatures:
			spawn_creature()
			
		print("Num creatures: " + str(GameState.num_existing_creatures))
		print("Max creatures: " + str(GameState.max_creatures))
		
		# Small chance to begin raining
		# Commented out for now
		#if randi_range(1, 30) == 1:
			#GameState.raining = not(GameState.raining)
			#player.toggle_rain_overlay()
		# Reset timer
		timer = timer_count

func spawn_food() -> void:
	var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
	
	# Instantiate food object
	var new_food = GameState.food_scene.instantiate()
	new_food.position = random_point
	add_child(new_food)

func spawn_food_near_position(position: Vector2, range: float) -> void:
	print("Spawn food near position!")
	var min_pos: Vector2 = Vector2(position.x - range, position.y - range)
	# Correction to stop out of bounds
	if min_pos.x <= $MinPos.position.x:
		min_pos.x = $MinPos.position.x
	if min_pos.y <= $MinPos.position.y:
		min_pos.y = $MinPos.position.y
	var max_pos: Vector2 = Vector2(position.x + range, position.y + range)
	# Correction to stop out of bounds
	if max_pos.x >= $MaxPos.position.x:
		max_pos.x = $MaxPos.position.x
	if max_pos.y >= $MaxPos.position.y:
		max_pos.y = $MaxPos.position.y
	var random_point = Vector2(randf_range(min_pos.x, max_pos.x), randf_range(min_pos.y, max_pos.y))

	# Instantiate food object
	var new_food = GameState.food_scene.instantiate()
	new_food.position = random_point
	add_child(new_food)

func spawn_creature() -> void:
	var new_creature
	
	# If the next creature to spawn is pre-set, do that
	if next_creature_type != "":
		match next_creature_type:
			"Predator":
				new_creature = GameState.predator_scene.instantiate()
			"PlantCreature":
				new_creature = GameState.plantcreature_scene.instantiate()
			"Bird":
				new_creature = GameState.bird_scene.instantiate()
		next_creature_type = ""
	
	# Otherwise, randomize the next creature spawn
	else:
		var randnum = randi_range(1, 6)
		if randnum == 1 and GameState.num_existing_creatures >= 5 and GameState.num_found_states >= 4:
			new_creature = GameState.predator_scene.instantiate()
		elif randnum == 2 and GameState.num_found_states >= 10:
			new_creature = GameState.plantcreature_scene.instantiate()
		elif randnum == 3 and GameState.num_found_states >= 15:
			new_creature = GameState.bird_scene.instantiate()
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
	GameState.max_creatures = 6 + int(GameState.num_found_states / 2)
	
	match GameState.num_found_states:
		3:
			player.interact_mode_unlocked("Place Food")
		4:
			next_creature_type = "Predator"
		10:
			player.interact_mode_unlocked("Pet")
			next_creature_type = "PlantCreature"
		14:
			player.interact_mode_unlocked("Poke")
		15:
			next_creature_type = "Bird"
		18:
			player.interact_mode_unlocked("Drag")
		20:
			next_creature_type = "Predator"

func on_clicked_food(food_position: Vector2) -> void:
	if GameState.num_found_states < 1:
		print("Not enough research done!")
		return
	
	if food_position.x <= $MinPos.position.x or food_position.x >= $MaxPos.position.x:
		return
	
	if food_position.y <= $MinPos.position.y or food_position.y >= $MaxPos.position.y:
		return
	
	# Instantiate food object
	# var place_for_food = get_viewport().get_mouse_position()
	var new_food = GameState.food_scene.instantiate()
	new_food.position = food_position
	new_food.lure = true
	add_child(new_food)
	# new_food.lure_creatures()

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
