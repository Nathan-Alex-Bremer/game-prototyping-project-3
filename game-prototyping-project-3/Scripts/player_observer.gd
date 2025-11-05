extends Node2D
class_name PlayerObserver

# Signals
signal ClickedFood(position: Vector2)
signal CapturedState(state: StringName)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("capture_screen"):
		print("Capture screen!")
		capture_creature_states()

func capture_creature_states() -> void:
	var creatures = get_tree().get_nodes_in_group("creature")
	
	for creature in creatures:
		if (0 <= creature.position.x and creature.position.x <= GameState.screen_size.x) and (0 <= creature.position.y and creature.position.y <= GameState.screen_size.y):
			var creature_statemachine: StateMachine = creature.get_node("StateMachine")
			
			if creature_statemachine == null:
				return
			
			var creature_state: StringName = creature_statemachine.current_state.name.to_lower()
			
			if creature_state == null:
				return
				
			CapturedState.emit(creature_state)
