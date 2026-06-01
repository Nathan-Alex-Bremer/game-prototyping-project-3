extends Node2D
## TUTORIAL SCENE
## I could have made this extend the base scene but OH WELL

## WARNING: This scene will crash on scene transition due to how the player is set up!
## This is not a problem for the final game but for testing, watch out!

# @export var player: PlayerObserver

@export var timer_count: float = 10
var timer: float

var player: PlayerObserver
var camera_area: CameraArea

var next_creature_type: StringName = ""

# State changing
var interact_mode_text: StringName = "Current Interact Mode: "

# Tutorial
var walk_distance: float = 0
var required_walk_distance: float = 2.5

signal journal_opened

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Ready!")
	timer = timer_count
	
	# Instantiate a player observer
	#camera_area = GameState.camera_area_scene.instantiate()
	#add_child(camera_area)
	
	if GameState.player_node:
		player = GameState.player_node
	else:
		player = GameState.player_scene.instantiate()
	player.position = Vector2(-170, 140)
	player.connect("CapturedState", on_capture_state)
	player.connect("ClickedFood", on_clicked_food)
	player.connect("OpenJournal", on_open_journal)
	player.connect("ChangeJournalPage", on_change_journal_page)
	player.connect("ChangeMode", on_change_mode)
	player.connect("EndDialogue", on_end_dialogue)
	player.connect("FallEvent", on_fall_event)
	player.connect("ShakeEvent", on_shake_event)
	player.connect("TutorialWalkUpdate", on_tutorial_walk_update)
	player.connect("TutorialUpdate", on_tutorial_update)
	player.connect("ToggleCreatureStats", on_toggle_creature_stats)
	player.connect("FadeOutComplete", on_fade_out_complete)
	player.connect("quit_to_menu", on_quit_to_menu)
	# player.connect_camera_area(camera_area)
	if not GameState.player_node:
		GameState.player_node = player
		add_child(player)
	
		
	player.initialize_text_box()
	player.toggle_text_box()
	player.set_step_sound("indoors")
	GameState.tutorial_mode = true
	print("Ready complete!")
	player.start_fade_in()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_capture_state(creature_type: StringName, state: StringName) -> void:
	for known_state in GameState.tutorial_found_states[creature_type]:
		if known_state == state:
			if GameState.tutorial_found_states[creature_type][state] == 0:
				var success = GameState.update_tutorial(3)
		
				if success:
					# Show relevant text
					player.initialize_text_box()
					player.toggle_text_box()
					
			GameState.tutorial_found_states[creature_type][state] += 1
			print("Found State: " + state)
			
			player.on_state_found(creature_type, state, GameState.tutorial_found_states[creature_type][state])
			return

func found_states_updated() -> void:
	GameState.max_creatures = 6 + int(GameState.num_found_states / 2)
				
# Add new stuff

func toggle_dyslexic_mode(val: bool) -> void:
	for creature in GameState.existing_creatures:
		creature.toggle_dyslexic_mode(val)

func on_clicked_food(food_position: Vector2) -> void:
	pass # Not sure if not having this breaks the game

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
	var success = GameState.update_tutorial(2)
		
	if success:
		# Show relevant text
		player.initialize_text_box()
		player.toggle_text_box()

func on_creature_leaving(creature_name: StringName) -> void:
	player.creature_left(creature_name)
	
func on_end_dialogue() -> void:
	match GameState.tutorial_stage:
		2: 
			player.show_camera_crosshair()
			return
		4:
			return
			# GameState.tutorial_mode = false # Remove all tutorial nonsense once the player can leave
	
	
func on_tutorial_walk_update(distance: float) -> void:
	walk_distance += distance
	# print("Walk distance: " + str(walk_distance))
	if walk_distance >= required_walk_distance:
		var success = GameState.update_tutorial(1)
		
		if success:
			# Show relevant text
			player.initialize_text_box()
			player.toggle_text_box()

func on_tutorial_update(stage: int) -> void:
	var success = GameState.update_tutorial(stage) # Awaiting just in case
	
	if success:
		# Show relevant text
		player.initialize_text_box()
		player.toggle_text_box()
	
	if GameState.tutorial_stage >= 4:
		$LabDoors.visible = false
		$LabDoors.process_mode = Node.PROCESS_MODE_DISABLED
		
func on_fall_event() -> void:
	# Instantiate tutorial creature
	# TODO: Add tutorial creature spawn
	# Instantiate a creature
	for i in range(1):
		var new_creature = GameState.tutorialcreature_scene.instantiate()
		new_creature.position = Vector2(-560, 240)
		new_creature.connect("SelectedForCheck", on_creature_selected_check)
		new_creature.connect("Leaving", on_creature_leaving)
		new_creature.connect("spawn_complete", on_tutorial_creature_spawn_complete)
		add_child(new_creature)
		GameState.existing_creatures.append(new_creature)
		new_creature.spawn_animation() # Play spawning animation

func on_shake_event() -> void:
	pass

func on_tutorial_creature_spawn_complete() -> void:
	player.event_finished()

func on_fade_out_complete() -> void:
	GameState.change_scene("BaseScene")
	
func _on_to_base_scene_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Transition found player")
		player.start_fade_out()

func on_quit_to_menu() -> void:
	GameState.change_scene("main_menu_scene")
