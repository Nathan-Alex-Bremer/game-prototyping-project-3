extends CharacterBody2D
class_name PlayerObserver


# Variables
# State changing
var interact_mode_text: StringName = "Current Interact Mode: "


var message_timer: float = 0

# Camera
# var camera_area: CameraArea
var camera_speed: float = 400
var camera_cooldown: float = 0
var camera_max_cooldown: float = 0.5

# Audio
@export_group("Sounds")

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var camera_sound: AudioStream
@export var notif_sound: AudioStream

@export var new_interact_mode_sound: AudioStream
@export var quest_complete_sound: AudioStream

@export_group("")

# Signals
signal ClickedFood(position: Vector2)
signal CapturedState(creature_type: StringName, state: StringName)
signal OpenJournal()
signal ChangeJournalPage(forward: bool)
signal ChangeMode(new_mode)
signal ToggleCreatureStats()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update flash
	$CameraArea.get_flash().modulate.a = lerp($CameraArea.get_flash().modulate.a, 0.0, 0.03)
	
	if camera_cooldown > 0:
		camera_cooldown -= delta
		
	if Input.is_action_just_pressed("pause"):
		print("Pausing!")
		$PauseMenu.visible = true
		$PauseMenu.accept_input = false
		get_tree().paused = true
		return
	
	if Input.is_action_just_pressed("capture_screen"):
		if camera_cooldown > 0:
			return
		print("Capture screen!")
		capture_creature_states()
		camera_cooldown = camera_max_cooldown
	
	# Cycle between action modes when the change is preseed
	if Input.is_action_just_pressed("change_action_mode"):
		
		match GameState.mode:
			GameState.INTERACT_MODES.CHECK:
				if GameState.num_found_states > 2 or GameState.debug_on:
					GameState.mode = GameState.INTERACT_MODES.PLACE_FOOD
					print("New action mode: Place Food")
					$CameraArea.set_interact_marker_visible(true)
					$InteractArea2D.visible = true
			GameState.INTERACT_MODES.PLACE_FOOD:
				if GameState.num_found_states > 9 or GameState.debug_on:
					GameState.mode = GameState.INTERACT_MODES.PET
					print("New action mode: Pet")
				else:
					GameState.mode = GameState.INTERACT_MODES.CHECK
					print("New action mode: Check")
					$CameraArea.set_interact_marker_visible(false)
					$InteractArea2D.visible = false
			GameState.INTERACT_MODES.PET:
				if GameState.num_found_states > 13 or GameState.debug_on:
					GameState.mode = GameState.INTERACT_MODES.POKE
					print("New action mode: Poke")
				else:
					GameState.mode = GameState.INTERACT_MODES.CHECK
					print("New action mode: Check")
					$CameraArea.set_interact_marker_visible(false)
					$InteractArea2D.visible = false
			GameState.INTERACT_MODES.POKE:
				if GameState.num_found_states > 17 or GameState.debug_on:
					GameState.mode = GameState.INTERACT_MODES.DRAG
					print("New action mode: Drag")
				else:
					GameState.mode = GameState.INTERACT_MODES.CHECK
					print("New action mode: Check")
					$CameraArea.set_interact_marker_visible(false)
					$InteractArea2D.visible = false
			GameState.INTERACT_MODES.DRAG:
				GameState.mode = GameState.INTERACT_MODES.CHECK
				print("New action mode: Check")
				$CameraArea.set_interact_marker_visible(false)
				$InteractArea2D.visible = false
		
		ChangeMode.emit(GameState.mode)
	
	if Input.is_action_just_pressed("use_action"):
		print("Use action!")
		match GameState.mode:
			GameState.INTERACT_MODES.PLACE_FOOD:
				if GameState.in_interact_range:
					var camera = get_viewport().get_camera_2d()
					ClickedFood.emit(camera.get_global_mouse_position())
				
	if Input.is_action_just_pressed("open_journal"):
		if GameState.player_in_quest_menu:
			return
		OpenJournal.emit()
		GameState.player_in_journal = not (GameState.player_in_journal)
	
	if Input.is_action_just_pressed("open_quest_manager"):
		if GameState.player_in_journal:
			return
		$QuestHandler.toggle_quest_menu()
	
	
	# Change page in journal
	if GameState.player_in_journal:
		if Input.is_action_just_pressed("move_right"):
			ChangeJournalPage.emit(true)
		if Input.is_action_just_pressed("move_left"):
			ChangeJournalPage.emit(false)
	
	if message_timer > 0:
		message_timer -= delta
		if message_timer <= 0:
			$UpdateLabel.text = ""
			message_timer = 0
			$Popup.visible = false
			$UpdateLabel.label_settings.font_color = Color(0.635, 0.998, 0.934)

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if (not GameState.player_in_journal):
	
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
	
	if velocity.length() > 0:
		# Normalize the movement direction vector
		velocity = velocity.normalized() * camera_speed
		if not $WalkStreamPlayer.playing:
			$WalkStreamPlayer.play()
	#elif $WalkStreamPlayer.playing:
		#$WalkStreamPlayer.stop()
	
	# $WalkStreamPlayer.playing = (velocity.length() > 0) # Only play when we're moving
	
	# Handles movement, collision, and sliding along collision surfaces
	var collision = move_and_slide()

#func connect_camera_area(cam: CameraArea) -> void:
	#camera_area = cam

func capture_creature_states() -> void:
	# Start camera flash effect
	$CameraArea.get_flash().modulate.a = 0.5
	$CameraAudioStreamPlayer.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightlyautoplay
	$CameraAudioStreamPlayer.play()
	
	# Record found states
	# var creatures = get_tree().get_nodes_in_group("creature")
	var creatures = $CameraArea.get_overlapping_bodies()
	
	for creature in creatures:
		if creature.is_in_group("creature") and creature.get_is_visible():
		# if (0 <= creature.position.x and creature.position.x <= GameState.screen_size.x) and (0 <= creature.position.y and creature.position.y <= GameState.screen_size.y):
			var creature_statemachine: StateMachine = creature.get_node("StateMachine")
			
			if creature_statemachine == null:
				return
			
			var creature_type: StringName = creature.get_type()
			var creature_state: StringName = creature_statemachine.current_state.simple_name
			
			if creature_state == null:
				return
				
			CapturedState.emit(creature_type, creature_state)
			
			$QuestHandler.update_quest(creature, creature_state)
			
			if GameState.get_state_in_journal(creature_type, creature_state):
				creature.change_label_color(Color(0.1, 1.0, 0.8, 1.0))
			else:
				creature.change_label_color(Color(0, 0.7, 0.65, 1.0))

func open_journal() -> void:
	$Journal.toggle_opened()
	$Journalnotif.visible = false
	
func change_journal_page(forward: bool) -> void:
	$Journal.change_page(forward)
	
func on_state_found(creature_type: StringName, state: StringName, times_found: int) -> void:
	print("On state found")
	$Journal.on_state_found(creature_type, state, times_found)
	if times_found == 1 or times_found == 5 or times_found == 10:
		$Journalnotif.visible = true
		$JournalAnimPlayer.play("JournalNotifBounce")
		play_sound(notif_sound)
	
func change_mode(mode: int) -> void:
	match mode:
		GameState.INTERACT_MODES.CHECK:
			$InteractModeLabel.text = interact_mode_text + "Check"
		GameState.INTERACT_MODES.PLACE_FOOD:
			# Since this is the state after Check, for now we disable visible stats here
			# TODO: Figure out some way to let the player keep this up and turn it on/off   
			GameState.selected_creature = null
			ToggleCreatureStats.emit()
			$InteractModeLabel.text = interact_mode_text + "Place Food"
		GameState.INTERACT_MODES.PET:
			$InteractModeLabel.text = interact_mode_text + "Pet"
		GameState.INTERACT_MODES.POKE:
			$InteractModeLabel.text = interact_mode_text + "Poke"
		GameState.INTERACT_MODES.DRAG:
			$InteractModeLabel.text = interact_mode_text + "Drag"

func update_message(message: String) -> void:
	$UpdateLabel.text = message
	message_timer = 5

func creature_left(creature_name: StringName) -> void:
	update_message(creature_name + " seems to have left...")
	
func creature_joined(creature_name: StringName) -> void:
	update_message(creature_name + " has arrived!")

func interact_mode_unlocked(mode: StringName) -> void:
	update_message("Great work, researcher!\nNew interact mode unlocked: " + mode + "! (Q)")
	$FanfareAudioStreamPlayer.play()
	$UpdateLabel.label_settings.font_color = Color(0.992, 0.887, 0.521)
	$Popup.visible = true

func toggle_rain_overlay() -> void:
	$RainingEffect.visible = (not $RainingEffect.visible)
	
# Audio

func play_sound(sound: AudioStream) -> void:
	audio_player.stream = sound
	audio_player.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
	audio_player.play()


func _on_interact_area_2d_mouse_entered() -> void:
	GameState.in_interact_range = true
	print("In interact range!")


func _on_interact_area_2d_mouse_exited() -> void:
	GameState.in_interact_range = false
	print("Out of interact range!")


func _on_quest_handler_quest_complete(quest: Quest) -> void:
	$Questnotif.visible = true
	$Questnotif/Label.text = "Quest Complete! (R)"
	$QuestAnimPlayer.play("QuestNotifBounce")
	## Maybe play sound to let the player know the quest is complete?
	# play_sound(quest_complete_sound)


func _on_quest_handler_new_quest() -> void:
	$Questnotif.visible = true
	$Questnotif/Label.text = "New quest available! (R)"
	$QuestAnimPlayer.play("QuestNotifBounce")


func _on_quest_handler_quest_menu_opened() -> void:
	$Questnotif.visible = false


func _on_walk_stream_player_finished() -> void:
	print("Finished")
	if velocity.length() > 0:
		$WalkStreamPlayer.pitch_scale = randf_range(0.8, 1.0) # Randomize pitch slightly
		# $WalkStreamPlayer.play()
