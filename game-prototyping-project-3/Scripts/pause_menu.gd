extends Node2D

var accept_input: bool = true

signal exit_button_pressed()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not accept_input:
		accept_input = true
		return
	if Input.is_action_just_pressed("pause"):
		# visible = false
		GameState.close_options_menu()
		$AnimationPlayer.play("slide_out")
		get_tree().paused = false
		set_process_input(false)
		

func on_pause() -> void:
	$AnimationPlayer.play("slide_in")
	set_process_input(true)

func _on_return_button_pressed() -> void:
	# visible = false
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("slide_out")
	get_tree().paused = false
	set_process_input(false)


func _on_settings_button_pressed() -> void:
	$AudioStreamPlayer.play()
	GameState.open_options_menu()


func _on_exit_button_pressed() -> void:
	$AudioStreamPlayer.play()
	visible = false
	GameState.close_options_menu()
	get_tree().paused = false
	exit_button_pressed.emit()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slide_out":
		visible = false
		GameState.on_unpause()
		
		print("Unpausing!")
