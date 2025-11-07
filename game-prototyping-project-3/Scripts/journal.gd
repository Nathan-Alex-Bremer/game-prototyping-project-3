extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# GameState.connect("StateFound", on_state_found)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_state_found(found_state: StringName) -> void:
	# This is such a gross way to do it
	$StatesFound.text = "Found States: " + str(GameState.num_found_states)
	
	match found_state:
		"Wander":
			$StateWander.text = "Wander State: TRUE"
		"Idle":
			$StateIdle.text = "Idle State: TRUE"
		"Move To Food":
			$StateMoveToFood.text = "Move To Food State: TRUE"
		"Eat":
			$StateEat.text = "Eat State: TRUE"
		"Rest":
			$StateRest.text = "Rest State: TRUE"
		"Pet":
			$StatePet.text = "Pet State: TRUE"
		"Annoyed":
			$StatePoke.text = "Annoyed State: TRUE"
	pass

func toggle_opened() -> void:
	print("Toggle opened")
	self.visible = (not self.visible)
