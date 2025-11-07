extends Node2D
class_name PlayerObserver


# Variables

# Signals
signal ClickedFood(position: Vector2)
signal CapturedState(state: StringName)
signal OpenJournal()
signal ChangeMode(new_mode)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("capture_screen"):
		print("Capture screen!")
		capture_creature_states()
	
	# Cycle between action modes when the change is preseed
	if Input.is_action_just_pressed("change_action_mode"):
		
		match GameState.mode:
			GameState.INTERACT_MODES.CHECK:
				GameState.mode = GameState.INTERACT_MODES.PLACE_FOOD
				print("New action mode: Place Food")
			GameState.INTERACT_MODES.PLACE_FOOD:
				GameState.mode = GameState.INTERACT_MODES.PET
				print("New action mode: Pet")
			GameState.INTERACT_MODES.PET:
				GameState.mode = GameState.INTERACT_MODES.POKE
				print("New action mode: Poke")
			GameState.INTERACT_MODES.POKE:
				GameState.mode = GameState.INTERACT_MODES.CHECK
				print("New action mode: Check")
		
		ChangeMode.emit(GameState.mode)
	
	if Input.is_action_just_pressed("use_action"):
		print("Use action!")
		match GameState.mode:
			GameState.INTERACT_MODES.PLACE_FOOD:
				ClickedFood.emit(get_viewport().get_mouse_position())
				
	if Input.is_action_just_pressed("open_journal"):
		OpenJournal.emit()
		

func capture_creature_states() -> void:
	var creatures = get_tree().get_nodes_in_group("creature")
	
	for creature in creatures:
		if (0 <= creature.position.x and creature.position.x <= GameState.screen_size.x) and (0 <= creature.position.y and creature.position.y <= GameState.screen_size.y):
			var creature_statemachine: StateMachine = creature.get_node("StateMachine")
			
			if creature_statemachine == null:
				return
			
			var creature_state: StringName = creature_statemachine.current_state.simple_name
			
			if creature_state == null:
				return
				
			CapturedState.emit(creature_state)
