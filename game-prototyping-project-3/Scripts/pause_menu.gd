extends Node2D

var accept_input: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not accept_input:
		accept_input = true
		return
	if Input.is_action_just_pressed("pause"):
		visible = false
		get_tree().paused = false
		print("Unpausing!")


func _on_return_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	print("Unpausing!")


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	pass # Replace with function body.
