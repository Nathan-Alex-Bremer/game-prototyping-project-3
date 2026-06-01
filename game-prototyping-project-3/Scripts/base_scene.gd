extends Node2D

# @export var player: PlayerObserver

@export var timer_count: float = 10
var timer: float

var player: PlayerObserver
var camera_area: CameraArea

var rain_enabled: bool = false # TO prevent too much rain early game

var next_creature_type: StringName = ""

# State changing
var interact_mode_text: StringName = "Current Interact Mode: "

signal journal_opened

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready!")
	timer = timer_count
	
	# Instantiate a player observer
	#camera_area = GameState.camera_area_scene.instantiate()
	#add_child(camera_area)
	
	# Create player only if starting in base scene, rather than from tutorial (for testing purposes)
	
	if GameState.player_node:
		player = GameState.player_node
	else:
		player = GameState.player_scene.instantiate()
		
		
	player.position = Vector2(0, 0)
	player.connect("CapturedState", on_capture_state)
	player.connect("ClickedFood", on_clicked_food)
	player.connect("OpenJournal", on_open_journal)
	player.connect("ChangeJournalPage", on_change_journal_page)
	player.connect("ChangeMode", on_change_mode)
	player.connect("ToggleCreatureStats", on_toggle_creature_stats)
	player.connect("QuestComplete", on_quest_complete)
	player.connect("HornSounded", on_horn_sounded)
	player.connect("BossFightStarted", on_boss_fight_started)
	player.connect("BossSatisfied", on_boss_satisfied)
	player.connect("BossQuestComplete", on_boss_quest_complete)
	player.connect("quit_to_menu", on_quit_to_menu)
	# player.connect_camera_area(camera_area)
	
	# Add newly created player as player node if starting in base scene (for testing purposes)
	if not GameState.player_node:
		GameState.player_node = player
		add_child(player)
		player.show_camera_crosshair()
		
		# Hacky testing solution for getting the options menu set up during testing
		var options_menu = GameState.options_menu_scene.instantiate()
		GameState.options_menu_node = options_menu
		player.add_child(options_menu)
	
	# Instantiate a creature
	for i in range(GameState.max_creatures):
		var new_creature = GameState.creature_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_creature.position = random_point
		new_creature.connect("SelectedForCheck", on_creature_selected_check)
		new_creature.connect("SpawnFood", spawn_food_near_position)
		new_creature.connect("Leaving", on_creature_leaving)
		add_child(new_creature)
		GameState.existing_creatures.append(new_creature)
	
	if GameState.debug_on:
		rain_enabled = true
		
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
		for i in range(1):
			var new_creature = GameState.frog_scene.instantiate()
			var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
			new_creature.position = random_point
			new_creature.connect("SelectedForCheck", on_creature_selected_check)
			new_creature.connect("Leaving", on_creature_leaving)
			add_child(new_creature)
			GameState.existing_creatures.append(new_creature)
	
	for i in range(5):
		var new_food = GameState.food_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_food.position = random_point
		add_child(new_food)
	for i in range(5):
		var new_bush = GameState.bush_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_bush.position = random_point
		add_child(new_bush)
	for i in range(5):
		var new_tree = GameState.tree_scene.instantiate()
		var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
		new_tree.position = random_point
		add_child(new_tree)
		
	GameState.tutorial_mode = false
	player.show_camera_crosshair()
	player.set_step_sound("grass")
	player.start_fade_in()
	
	if GameState.debug_on:
		GameState.check_unlocked = true
		GameState.place_food_unlocked = true
		GameState.pet_unlocked = true
		GameState.poke_unlocked = true
		GameState.drag_unlocked = true
		GameState.horn_unlocked = true
		
		player.interact_mode_unlocked(GameState.INTERACT_MODES.PLACE_FOOD)
		player.interact_mode_unlocked(GameState.INTERACT_MODES.PET)
		player.interact_mode_unlocked(GameState.INTERACT_MODES.POKE)
		player.interact_mode_unlocked(GameState.INTERACT_MODES.DRAG)
		player.interact_mode_unlocked(GameState.INTERACT_MODES.HORN)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	
	if GameState.raining:
		if randi_range(1, 10) == 10:
			var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
	
			# Instantiate food object
			# Only spawn if randomly chosen position is in/near viewing range
			if random_point.distance_to(player.position) <= 600:
				var new_drop = GameState.raindrop_scene.instantiate()
				new_drop.position = random_point
				add_child(new_drop)
			
	
	if timer <= 0:
		# TODO: Add check for max food amount here
		if randi_range(1, 3) == 3:
			spawn_food()
			
		GameState.raining = true
		$AnimationPlayer.play("rain_fade_in")
		player.toggle_rain_overlay(GameState.raining)
		
		# Redefining this thing is annoying, maybe move the variable and just change the value each time
		var required_spawn_roll = 5
		if GameState.num_existing_creatures <= (GameState.max_creatures / 2):
			required_spawn_roll -= 1 # More creatures are more likely if we're far below the cap
		if GameState.num_food <= 10: # More creatures are more likely with a lot of food
			required_spawn_roll -= 1
		if randi_range(1, 5) >= required_spawn_roll and GameState.num_existing_creatures < GameState.max_creatures:
			spawn_creature()
			
		print("Num creatures: " + str(GameState.num_existing_creatures))
		print("Max creatures: " + str(GameState.max_creatures))
		
		# Small chance to begin raining
		if randi_range(1, 20) == 1 and rain_enabled:
			GameState.raining = not(GameState.raining)
			if GameState.raining:
				$AnimationPlayer.play("rain_fade_in")
			else:
				$AnimationPlayer.play("rain_fade_out")
			player.toggle_rain_overlay(GameState.raining)
		
		# Small chance to play song
		if randi_range(1, 30) == 1 and not $BGM.playing:
			$BGM.play()
		
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
			"Frog":
				new_creature = GameState.frog_scene.instantiate()
		next_creature_type = ""
	
	# Otherwise, randomize the next creature spawn
	else:
		var randnum = randi_range(1, 6)
		if randnum == 1 and GameState.num_existing_creatures >= 5 and GameState.num_found_states >= 4 and not GameState.raining:
			new_creature = GameState.predator_scene.instantiate()
		elif randnum == 2 and GameState.num_found_states >= 10:
			new_creature = GameState.plantcreature_scene.instantiate()
		elif randnum == 1 and GameState.num_found_states >= 18:
			new_creature = GameState.frog_scene.instantiate()
		elif randnum == 3 and GameState.num_found_states >= 25:
			new_creature = GameState.bird_scene.instantiate()
		else:
			new_creature = GameState.creature_scene.instantiate()
			
	var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
	new_creature.position = random_point
	new_creature.connect("SelectedForCheck", on_creature_selected_check)
	new_creature.connect("SpawnFood", spawn_food_near_position)
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
	match GameState.num_found_states:
		3:
			player.interact_mode_unlocked(GameState.INTERACT_MODES.PLACE_FOOD)
			GameState.place_food_unlocked = true
		4:
			next_creature_type = "Predator"
			GameState.num_creatures_discovered += 1
			if GameState.raining:
				GameState.raining = false
				$AnimationPlayer.play("rain_fade_out")
				player.toggle_rain_overlay(GameState.raining)
			
		10:
			player.interact_mode_unlocked(GameState.INTERACT_MODES.PET)
			GameState.pet_unlocked = true
			next_creature_type = "PlantCreature"
			GameState.num_creatures_discovered += 1
		16:
			player.interact_mode_unlocked(GameState.INTERACT_MODES.POKE)
			GameState.poke_unlocked = true
		
		18:
			next_creature_type = "Frog"
			GameState.num_creatures_discovered += 1
			rain_enabled = true
			if not GameState.raining:
				GameState.raining = true
				$AnimationPlayer.play("rain_fade_in")
				player.toggle_rain_overlay(GameState.raining)
			
		20:
			if not GameState.raining:
				next_creature_type = "Predator"
		
		25:
			player.interact_mode_unlocked(GameState.INTERACT_MODES.DRAG)
			GameState.drag_unlocked = true
			next_creature_type = "Bird"
			GameState.num_creatures_discovered += 1
	
	GameState.max_creatures = 5 + int(GameState.num_found_states / 3) + GameState.num_creatures_discovered
		

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
	new_food.first_pressed = true
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

func on_creature_leaving(creature_type: StringName, creature_name: StringName) -> void:
	# Handle boss leaving
	if creature_type == "Boss":
		GameState.boss_active = false
	player.creature_left(creature_name)

func on_quest_complete() -> void:
	if not $BGM.playing:
			$BGM.play()

func on_horn_sounded() -> void:
	for creature in GameState.existing_creatures:
		if not (creature is Boss): # TODO: this is proper syntax right
			creature.set_panic(true)

func toggle_dyslexic_mode(val: bool) -> void:
	for creature in GameState.existing_creatures:
		creature.toggle_dyslexic_mode(val)

func on_boss_fight_started() -> void:
	# Spawn boss
	var new_creature = GameState.boss_scene.instantiate()
	var random_point = Vector2(randf_range($MinPos.position.x, $MaxPos.position.x), randf_range($MinPos.position.y, $MaxPos.position.y))
	new_creature.position = random_point
	new_creature.connect("SelectedForCheck", on_creature_selected_check)
	new_creature.connect("SpawnFood", spawn_food_near_position)
	new_creature.connect("Leaving", on_creature_leaving)
	add_child(new_creature)
	player.camera_shake_single(0.5)
	GameState.existing_creatures.append(new_creature)
	GameState.boss_active = true
	GameState.boss_ever_summoned = true

func on_boss_satisfied() -> void:
	for creature in GameState.existing_creatures:
		if creature is Boss:
			creature.set_satisfied()

func on_boss_quest_complete() -> void:
	for creature in GameState.existing_creatures:
		if creature is Boss:
			creature.set_quest_completed()
		else:
			creature.set_celebrate(true)

func on_quit_to_menu() -> void:
	GameState.change_scene("main_menu_scene")
