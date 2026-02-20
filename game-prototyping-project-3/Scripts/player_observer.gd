extends CharacterBody2D
class_name PlayerObserver


# Variables
# State changing
var interact_mode_text: StringName = "Current Interact Mode: "


var message_timer: float = 0

# Camera
var camera_speed: float = 400
var camera_cooldown: float = 0
var camera_max_cooldown: float = 0.5

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
	$Flash.modulate.a = lerp($Flash.modulate.a, 0.0, 0.03)
	
	if camera_cooldown > 0:
		camera_cooldown -= delta
	
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
				if GameState.num_found_states > 4:
					GameState.mode = GameState.INTERACT_MODES.PLACE_FOOD
					print("New action mode: Place Food")
			GameState.INTERACT_MODES.PLACE_FOOD:
				if GameState.num_found_states > 9:
					GameState.mode = GameState.INTERACT_MODES.PET
					print("New action mode: Pet")
				else:
					GameState.mode = GameState.INTERACT_MODES.CHECK
					print("New action mode: Check")
			GameState.INTERACT_MODES.PET:
				if GameState.num_found_states > 13:
					GameState.mode = GameState.INTERACT_MODES.POKE
					print("New action mode: Poke")
				else:
					GameState.mode = GameState.INTERACT_MODES.CHECK
					print("New action mode: Check")
			GameState.INTERACT_MODES.POKE:
				if GameState.num_found_states > 17:
					GameState.mode = GameState.INTERACT_MODES.DRAG
					print("New action mode: Drag")
				else:
					GameState.mode = GameState.INTERACT_MODES.CHECK
					print("New action mode: Check")
			GameState.INTERACT_MODES.DRAG:
				GameState.mode = GameState.INTERACT_MODES.CHECK
				print("New action mode: Check")
		
		ChangeMode.emit(GameState.mode)
	
	if Input.is_action_just_pressed("use_action"):
		print("Use action!")
		match GameState.mode:
			GameState.INTERACT_MODES.PLACE_FOOD:
				var camera = get_viewport().get_camera_2d()
				ClickedFood.emit(camera.get_global_mouse_position())
				
	if Input.is_action_just_pressed("open_journal"):
		OpenJournal.emit()
		GameState.player_in_journal = not (GameState.player_in_journal)
	
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
			$UpdateLabel.modulate = Color(1, 1, 1)

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
	
	# Handles movement, collision, and sliding along collision surfaces
	var collision = move_and_slide()

func capture_creature_states() -> void:
	# Start camera flash effect
	$Flash.modulate.a = 0.5
	
	# Record found states
	var creatures = get_tree().get_nodes_in_group("creature")
	
	for creature in creatures:
		if creature.get_is_visible():
		# if (0 <= creature.position.x and creature.position.x <= GameState.screen_size.x) and (0 <= creature.position.y and creature.position.y <= GameState.screen_size.y):
			var creature_statemachine: StateMachine = creature.get_node("StateMachine")
			
			if creature_statemachine == null:
				return
			
			var creature_type: StringName = creature.get_type()
			var creature_state: StringName = creature_statemachine.current_state.simple_name
			
			if creature_state == null:
				return
				
			CapturedState.emit(creature_type, creature_state)

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
	update_message("Great work, researcher!\nNew interact mode unlocked: " + mode + "!")
	$UpdateLabel.modulate = Color(0.4, 0.4, 0.4)
	$Popup.visible = true

func toggle_rain_overlay() -> void:
	$RainingEffect.visible = (not $RainingEffect.visible)
