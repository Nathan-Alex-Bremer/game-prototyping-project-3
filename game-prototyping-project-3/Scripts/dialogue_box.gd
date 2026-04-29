extends Node2D
class_name DialogueBox

var open: bool = false # Is this even necessary?
@onready var label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_text(text: String) -> void:
	label.text = text
	
func show_hide_box() -> void:
	visible = not open
	open = not open
	
	# Update game state
	GameState.dialogue_open = open
