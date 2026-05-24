extends CharacterBody2D
class_name PlayerObserver


# Variables
# State changing
var interact_mode_text: StringName = "Current Interact Mode: "


var message_timer: float = 0
var unlock_message_timer: float = 0

# Camera
# var camera_area: CameraArea
var camera_speed: float = 400
var camera_cooldown: float = 0
var camera_max_cooldown: float = 0.5

var camera_unlocked: bool = false
var camera_invalid: bool = false

# Notifs
@export var journal_notif_on_sprite: Texture2D
@export var journal_notif_off_sprite: Texture2D
@export var quest_notif_on_sprite: Texture2D
@export var quest_notif_off_sprite: Texture2D

# Transition stuff
var fading_out: bool = false
var fading_in: bool = false

# Ending stuff
var ending_queued: bool = false
var ending_timer: float = 0
var ending_timer_max: float = 15
var ending: bool = false
var ending_fading_out: bool = false

# Audio
@export_group("Sounds")

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var camera_sound: AudioStream
@export var text_sound: AudioStream
@export var notif_sound: AudioStream
@export var horn_sound: AudioStream

@export var new_interact_mode_sound: AudioStream
@export var quest_complete_sound: AudioStream

@export var step_sound_grass: AudioStream
@export var step_sound_indoors: AudioStream

@export var shake_sound: AudioStream

@export_group("")

# Animation
@onready var player_animation_player: AnimationPlayer = $PlayerContainer/PlayerContainer2/Sprite2D/AnimationPlayer

# Tutorial stuff
var walk_distance: float = 0

# Boss stuff (this shouldn't be necessary but we're doing it anyways)
var play_footsteps: bool = false

# Dialogue Box
@onready var dialogue_box: DialogueBox = $DialogueBox

# Dialogue collection
@export var tutorial_dialogue: Array[DialogueSet]
var current_dialogue: Array[String]
var dialogue_line: int # Current line of dialogue to pull
var event_active: bool = false

# Signals
signal ClickedFood(position: Vector2)
signal CapturedState(creature_type: StringName, state: StringName)
signal OpenJournal()
signal ChangeJournalPage(forward: bool)
signal ChangeMode(new_mode)
signal ToggleCreatureStats()

signal TutorialWalkUpdate(distance: float)
signal TutorialUpdate(stage: int)
signal EndDialogue()
signal FallEvent() # For plush spawn
signal ShakeEvent() # For screen shake
signal FadeOutComplete()

signal HornSounded()
signal BossFightStarted() # For when the boss fight quest is begun/the game needs to spawn a Boss
signal BossSatisfied() # For when the boss fight quest is begun/the game needs to spawn a Boss
signal BossQuestComplete() # For when the boss fight quest is begun/the game needs to spawn a Boss

signal quit_to_menu() # For quitting to menu


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update flash
	
	$CameraArea.get_flash().modulate.a = lerp($CameraArea.get_flash().modulate.a, 0.0, 0.03)
	
	if camera_cooldown > 0:
		camera_cooldown -= delta
		
	# Handling text
	if message_timer > 0:
		message_timer -= delta
		if message_timer <= 0:
			$UpdateLabel.text = ""
			message_timer = 0
	
	# Handling text
	if unlock_message_timer > 0:
		unlock_message_timer -= delta
		if unlock_message_timer <= 0:
			unlock_message_timer = 0
			$Popup/AnimationPlayer.play("popup_slide_out")
	
	# Handling fade out/in
	if fading_out:
		fade_out(delta)
	
	elif fading_in:
		fade_in(delta)
		
	
	# Handling ending
	if ending_queued:
		ending_timer -= delta
		if ending_timer <= 0:
			ending = true
			$EndScreen.fading_out = true
			get_tree().paused = true
			
	# UGHHHHHHHHH
	# Trying to prevent taking photos on the interact bar
	
	
	# Don't let the player input anything during screen transition
	if not GameState.input_allowed:
		return
		
	if Input.is_action_just_pressed("pause"):
		print("Pausing!")
		$PauseMenu.visible = true
		$PauseMenu.accept_input = false
		$PauseMenu.on_pause()
		get_tree().paused = true
		return
	
	if Input.is_action_just_pressed("capture_screen"):
		
		# Advance text if dialogue screen is open
		if GameState.dialogue_open:
			if event_active:
				return
			print("Click to advance!")
			play_sound(text_sound)
			advance_text()
			return
			
		if GameState.tutorial_mode:
			# Don't let the player take pictures before the proper tutorial point
			if GameState.tutorial_stage < 2:
				return
		
		if camera_cooldown > 0:
			return
			
		if camera_invalid:
			return
			
		# TODO: Just use camera_invalid for all of this maybe?
		if GameState.player_in_journal or GameState.player_in_quest_menu:
			return
		print("Capture screen!")
		capture_creature_states()
		camera_cooldown = camera_max_cooldown
	
	if Input.is_action_just_pressed("confirm"):
		if GameState.dialogue_open:
			print("Click to advance!")
			play_sound(text_sound)
			advance_text()
	
	# Cycle between action modes when the change is preseed
	if Input.is_action_just_pressed("change_action_mode"):
		
		# Don't register any non-pause, non-click inputs when menuing
		if GameState.player_in_journal or GameState.player_in_quest_menu or GameState.dialogue_open:
			return
		
		
		
		change_mode(GameState.mode)
		# ChangeMode.emit(GameState.mode)
	
	if Input.is_action_just_pressed("use_action"):
		# Don't register any non-pause, non-click inputs when menuing
		if GameState.player_in_journal or GameState.player_in_quest_menu or GameState.dialogue_open:
			return
			
		print("Use action!")
		match GameState.mode:
			GameState.INTERACT_MODES.PLACE_FOOD:
				if GameState.in_interact_range:
					var camera = get_viewport().get_camera_2d()
					ClickedFood.emit(camera.get_global_mouse_position())
			GameState.INTERACT_MODES.HORN:
				HornSounded.emit()
				$HornAudioStreamPlayer.play()
				# play_sound(horn_sound)
				if GameState.horn_sounded:
					if not GameState.boss_active and GameState.boss_ever_summoned:
						BossFightStarted.emit()
						update_message("Something is coming...")
				else:
					GameState.horn_sounded = true
					play_footsteps = true
					$QuestHandler.check_new_availability() # Update quest line
					print("Horn sounded")
					update_message("Something is coming... Check the Quest Log!")
				# TODO: Set GameState horn sounded, set quest available if not prior, else summon new boss, add popup
				
	if Input.is_action_just_pressed("open_journal"):
		if GameState.player_in_quest_menu or GameState.dialogue_open:
			return
			
		if GameState.tutorial_mode and GameState.tutorial_stage < 3:
			return
		# OpenJournal.emit()
		open_journal()
		GameState.player_in_journal = not (GameState.player_in_journal)
	
	if Input.is_action_just_pressed("open_quest_manager"):
		if GameState.tutorial_mode:
			return
			
		if GameState.player_in_journal or GameState.dialogue_open:
			return
		$QuestHandler.toggle_quest_menu()
	
	
	# Change page in journal
	if GameState.player_in_journal:
		if Input.is_action_just_pressed("move_right"):
			change_journal_page(true)
			# ChangeJournalPage.emit(true)
		if Input.is_action_just_pressed("move_left"):
			# ChangeJournalPage.emit(false)
			change_journal_page(false)

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if not GameState.input_allowed:
		return
	
	if (not GameState.player_in_journal and not GameState.player_in_quest_menu and not GameState.dialogue_open):
	
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
		#if not $WalkStreamPlayer.playing:
			#$WalkStreamPlayer.play()
		
		# TODO: Implement walk animation, make it look good
		if not player_animation_player.is_playing():
			if randi_range(1, 2) == 1:
				player_animation_player.play("walk")
			else:
				player_animation_player.play("walk_2")
		
		
			
		# Handle tutorial
		if GameState.tutorial_mode and GameState.tutorial_stage == 0:
			TutorialWalkUpdate.emit(delta)
			
	#else:
		#player_animation_player.stop()
	#elif $WalkStreamPlayer.playing:
		#$WalkStreamPlayer.stop()
	
	# $WalkStreamPlayer.playing = (velocity.length() > 0) # Only play when we're moving
	
	# Handles movement, collision, and sliding along collision surfaces
	var collision = move_and_slide()

#func connect_camera_area(cam: CameraArea) -> void:
	#camera_area = cam

func reset_state() -> void:
	ending_queued = false
	ending = false
	ending_fading_out = false
	
	walk_distance = 0
	play_footsteps = false
	
	event_active = false
	
	$QuestHandler.reset_state()
	$Journal.reset_state()
	
func capture_creature_states() -> void:
	
	# Start camera flash effect
	if not GameState.flash_disabled:
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
			
			# Tutorial only has one state, just let em have it
			if GameState.tutorial_mode:
				creature.change_label_color(Color(0.1, 1.0, 0.8, 1.0))
			
			# Update label colors
			if GameState.get_state_in_journal(creature_type, creature_state):
				creature.change_label_color(Color(0.1, 1.0, 0.8, 1.0))
			else:
				creature.change_label_color(Color(0, 0.7, 0.65, 1.0))

func open_journal() -> void:
	if GameState.tutorial_mode and GameState.tutorial_stage < 3:
		return # I'd like the player to be able to open the journal ahead of this, but just not progress
		
	$Journal.toggle_opened()
	toggle_journal_notif(false)
	$Journalnotif/Label.visible = false
	$Journalnotif/Label.text = "New info unlocked - check the Journal! (E)" # TODO: Less hacky way to rever journal text
	
func change_journal_page(forward: bool) -> void:
	$Journal.change_page(forward)
	
func on_state_found(creature_type: StringName, state: StringName, times_found: int) -> void:
	print("On state found")
	if $Journal.is_new_creature(creature_type):
		$Journalnotif/Label.text = "New creature discovered - check the Journal! (E)"
	$Journal.on_state_found(creature_type, state, times_found)
	if times_found == 1 or times_found == 5 or times_found == 10:
		toggle_journal_notif(true)
		$Journalnotif/Label.visible = true
		$JournalAnimPlayer.play("JournalNotifBounce")
		play_sound(notif_sound)
	

func change_mode(mode: int) -> void:
	
	var prev_mode = GameState.mode
	
	match GameState.mode:
		GameState.INTERACT_MODES.CHECK:
			if GameState.place_food_unlocked or GameState.debug_on:
				GameState.update_interact_mode(GameState.INTERACT_MODES.PLACE_FOOD)
				print("New action mode: Place Food")
		GameState.INTERACT_MODES.PLACE_FOOD:
			if GameState.pet_unlocked or GameState.debug_on:
				GameState.update_interact_mode(GameState.INTERACT_MODES.PET)
				print("New action mode: Pet")
			else:
				GameState.update_interact_mode(GameState.INTERACT_MODES.CHECK)
				print("New action mode: Check")
		GameState.INTERACT_MODES.PET:
			if GameState.poke_unlocked or GameState.debug_on:
				GameState.update_interact_mode(GameState.INTERACT_MODES.POKE)
				print("New action mode: Poke")
			else:
				GameState.update_interact_mode(GameState.INTERACT_MODES.CHECK)
				print("New action mode: Check")
		GameState.INTERACT_MODES.POKE:
			if GameState.drag_unlocked or GameState.debug_on:
				GameState.update_interact_mode(GameState.INTERACT_MODES.DRAG)
				print("New action mode: Drag")
			else:
				GameState.update_interact_mode(GameState.INTERACT_MODES.CHECK)
				print("New action mode: Check")
		GameState.INTERACT_MODES.DRAG:
			if GameState.horn_unlocked or GameState.debug_on:
				GameState.update_interact_mode(GameState.INTERACT_MODES.HORN)
				print("New action mode: Ancient Horn")
			else:
				GameState.update_interact_mode(GameState.INTERACT_MODES.CHECK)
				print("New action mode: Check")
		GameState.INTERACT_MODES.HORN:
			GameState.update_interact_mode(GameState.INTERACT_MODES.CHECK)
			print("New action mode: Check")
			
	$InteractBar.update_highlight(prev_mode, GameState.mode)
	
	#match mode:
		#GameState.INTERACT_MODES.CHECK:
			#$InteractModeLabel.text = interact_mode_text + "Check"
		#GameState.INTERACT_MODES.PLACE_FOOD:
			## Since this is the state after Check, for now we disable visible stats here
			## TODO: Figure out some way to let the player keep this up and turn it on/off   
			#GameState.selected_creature = null
			#ToggleCreatureStats.emit()
			#$InteractModeLabel.text = interact_mode_text + "Place Food"
		#GameState.INTERACT_MODES.PET:
			#$InteractModeLabel.text = interact_mode_text + "Pet"
		#GameState.INTERACT_MODES.POKE:
			#$InteractModeLabel.text = interact_mode_text + "Poke"
		#GameState.INTERACT_MODES.DRAG:
			#$InteractModeLabel.text = interact_mode_text + "Drag"
		#GameState.INTERACT_MODES.HORN:
			#$InteractModeLabel.text = interact_mode_text + "Ancient Horn"

func update_message(message: String) -> void:
	# Show new message and reset message timer, unless the popup is visible
	# TODO: Maybe just keep the two message types separate?
	$UpdateLabel.text = message
	message_timer = 5

func update_popup_message(message: String) -> void:
	# Show new message and reset message timer, unless the popup is visible
	# TODO: Maybe just keep the two message types separate?
	$Popup/UnlockLabel.text = message
	unlock_message_timer = 3

func update_interact_highlights() -> void:
	if GameState.mode == GameState.INTERACT_MODES.CHECK:
		$CameraArea.set_interact_marker_visible(false)
		$InteractArea2D.visible = false
	else:
		$CameraArea.set_interact_marker_visible(true)
		$InteractArea2D.visible = true
	
func creature_left(creature_name: StringName) -> void:
	update_message(creature_name + " seems to have left...")
	
func creature_joined(creature_name: StringName) -> void:
	update_message(creature_name + " has arrived!")

func interact_mode_unlocked(mode: GameState.INTERACT_MODES) -> void:
	var mode_name: StringName = ""
	match mode:
		GameState.INTERACT_MODES.CHECK:
			mode_name = "Check"
		GameState.INTERACT_MODES.PLACE_FOOD:
			mode_name = "Place Food"
		GameState.INTERACT_MODES.PET:
			mode_name = "Pet"
		GameState.INTERACT_MODES.POKE:
			mode_name = "Poke"
		GameState.INTERACT_MODES.DRAG:
			mode_name = "Drag"
		GameState.INTERACT_MODES.HORN:
			mode_name = "Ancient Horn"
	update_popup_message("Great work, researcher!\nNew interact mode unlocked: " + mode_name + "! (Q)")
	$FanfareAudioStreamPlayer.play()
	$Popup/AnimationPlayer.play("popup_slide_in")
	$InteractBar.unlock_interact_mode(mode)

func toggle_rain_overlay(val: bool) -> void:
	if val:
		$RainAnimationPlayer.play("rain_fade_in")
	else:
		$RainAnimationPlayer.play("rain_fade_out")
	# $RainingEffect.visible = (not $RainingEffect.visible)
	
# Audio

func play_sound(sound: AudioStream) -> void:
	audio_player.stream = sound
	audio_player.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
	audio_player.play()

func set_step_sound(sound: StringName) -> void:
	match sound:
		"grass":
			$WalkStreamPlayer.stream = step_sound_grass
		"indoors":
			$WalkStreamPlayer.stream = step_sound_indoors

# Dialogue

func toggle_text_box() -> void:
	# Opens/closes text box
	dialogue_box.show_hide_box()

func initialize_text_box() -> void:
	# Prepare text box for next dialogue set
	# NOTE: Currently only set to work for tutorial!
	current_dialogue = tutorial_dialogue[GameState.tutorial_stage].dialogue
	dialogue_line = 0
	dialogue_box.set_text(current_dialogue[dialogue_line])
	
func advance_text() -> void:
	# Display next dialogue line
	dialogue_line += 1
	if dialogue_line >= current_dialogue.size():
		toggle_text_box()
		
		# Ideally this would be held in the dialogue box but for now this'll do
		EndDialogue.emit()
		
		return
		
	# Special events
	
	if current_dialogue[dialogue_line] == "FALLEVENT":
		FallEvent.emit()
		event_active = true
		return
	
	if current_dialogue[dialogue_line] == "SHAKEEVENT":
		event_active = true
		camera_shake(0.5)
		return
		
	dialogue_box.set_text(current_dialogue[dialogue_line])
	

func camera_shake(multiplier: float) -> void:
	$Camera2D.apply_shake(multiplier)
	play_sound(shake_sound)
	await get_tree().create_timer(1.5).timeout
	event_finished()
	
func camera_shake_multi(multiplier: float) -> void:
	$Camera2D.apply_shake(multiplier)
	play_sound(shake_sound)
	await get_tree().create_timer(1.5).timeout
	$Camera2D.apply_shake(multiplier)
	play_sound(shake_sound)
	await get_tree().create_timer(1.5).timeout
	$Camera2D.apply_shake(multiplier)
	play_sound(shake_sound)
	await get_tree().create_timer(1.5).timeout

func camera_shake_single(multiplier: float) -> void:
	$Camera2D.apply_shake(multiplier)
	play_sound(shake_sound)
	
# Events
func event_finished() -> void:
	event_active = false
	advance_text()

# Notifs

func toggle_journal_notif(active: bool) -> void:
	if active:
		$Journalnotif/JournalIcon.texture = journal_notif_on_sprite
		$Journalnotif/JournalIcon.modulate.a = 1.0
	else:
		$Journalnotif/JournalIcon.texture = journal_notif_off_sprite
		$Journalnotif/JournalIcon.modulate.a = 0.5

func toggle_quest_notif(active: bool) -> void:
	if active:
		$Questnotif/QuestIcon.texture = quest_notif_on_sprite
		$Questnotif/QuestIcon.modulate.a = 1.0
	else:
		$Questnotif/QuestIcon.texture = quest_notif_off_sprite
		$Questnotif/QuestIcon.modulate.a = 0.5

# Tutorial
func show_camera_crosshair() -> void:
	camera_unlocked = true
	$CameraArea.set_camera_crosshair_visible(true)
	
# Transitions (Fade)

func start_fade_out() -> void:
	print("Start fade out")
	GameState.input_allowed = false
	fading_out = true

func fade_out(delta: float) -> void:
	if $Flash.modulate.a + delta >= 1:
		print("Fade out complete")
		$Flash.modulate.a = 1
		fading_out = false
		# signal
		FadeOutComplete.emit()
	else:
		$Flash.modulate.a += delta

func start_fade_in() -> void:
	fading_in = true

func fade_in(delta: float) -> void:
	if $Flash.modulate.a - delta <= 0:
		$Flash.modulate.a = 0
		GameState.input_allowed = true
		FadeOutComplete.emit()
		# signal
	else:
		$Flash.modulate.a -= delta

# Visuals
func toggle_high_contrast(val: bool) -> void:
	print("Toggle high contrast")
	if val:
		$Contrast/ColorRect.set_shader_parameter("contrast", 0.5)
	else:
		$Contrast/ColorRect.set_shader_parameter("contrast", 0.0)
		

# Ending

func start_ending() -> void:
	ending_queued = true
	ending_timer = ending_timer_max

# Signal Connection

func _on_interact_area_2d_mouse_entered() -> void:
	GameState.in_interact_range = true
	print("In interact range!")


func _on_interact_area_2d_mouse_exited() -> void:
	GameState.in_interact_range = false
	print("Out of interact range!")


func _on_quest_handler_quest_complete(quest: Quest) -> void:
	toggle_quest_notif(true)
	$Questnotif/Label.visible = true
	$Questnotif/Label.text = "Quest Complete! (R)"
	$QuestAnimPlayer.play("QuestNotifBounce")
	
	if quest is Quest06:
		BossSatisfied.emit()
	## Maybe play sound to let the player know the quest is complete?
	if not audio_player.is_playing():
		play_sound(notif_sound)


func _on_quest_handler_new_quest() -> void:
	toggle_quest_notif(true)
	$Questnotif/Label.visible = true
	$Questnotif/Label.text = "New quest available! (R)"
	$QuestAnimPlayer.play("QuestNotifBounce")


func _on_quest_handler_quest_menu_opened() -> void:
	toggle_quest_notif(false)
	$Questnotif/Label.visible = false


#func _on_walk_stream_player_finished() -> void:
	#print("Finished")
	#if velocity.length() > 0:
		#$WalkStreamPlayer.pitch_scale = randf_range(0.8, 1.0) # Randomize pitch slightly
		#$WalkStreamPlayer.play()

func step_noise() -> void:
	print("Finished")
	if velocity.length() > 0:
		$WalkStreamPlayer.pitch_scale = randf_range(0.8, 1.0) # Randomize pitch slightly
		$WalkStreamPlayer.play()


func _on_journal_tutorial_close() -> void:
	TutorialUpdate.emit(4)
	pass # Replace with function body.


func _on_quest_handler_quest_complete_popup(creature_type: StringName) -> void:
	$Journal.toggle_star(creature_type) #TODO: Test
	
	if creature_type == "Boss":
		BossQuestComplete.emit()
	pass # Replace with function body.


func _on_quest_handler_quest_started(quest: Quest) -> void:
	if quest.creature_type == "Boss" and not GameState.boss_ever_summoned:
		BossFightStarted.emit()


func _on_camera_area_toggle_photo_mode(val: bool) -> void:
	# Toggling ability to use camera
	# TODO: This is so so gross find a better way to do it please
	if not camera_unlocked:
		return
		
	if val:
		$CameraArea.set_camera_crosshair_visible(true)
		camera_invalid = false
	else:
		$CameraArea.set_camera_crosshair_visible(false)
		camera_invalid = true

func _on_horn_audio_stream_player_finished() -> void:
	print("Audio stream finished!")
	# Hacky way to get the shaking to happen only once
	if play_footsteps:
		play_footsteps = false
		camera_shake_multi(0.5)

func _on_pause_menu_exit_button_pressed() -> void:
	quit_to_menu.emit()

func toggle_dyslexic_mode(val: bool) -> void:
	
	# NOT WORKING! WHY!
	if val:
		var id: int = 0
		for child in find_children("", "Label", true, true):
			if child is Label:
				print(str(id))
				id += 1
				child.add_theme_font_override("font", load("res://Fonts/OpenDyslexic-Regular.otf"))

	else:
		for child in find_children("", "Label", true, true):
			if child is Label:
				child.add_theme_font_override("font", load("res://Fonts/lazy_dog.ttf"))
