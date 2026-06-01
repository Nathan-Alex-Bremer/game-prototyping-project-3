extends Node2D

# Variables
var fading_out: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameState.player_node:
		GameState.player_node.process_mode = Node.PROCESS_MODE_DISABLED
		GameState.player_node.visible = false
		GameState.player_node.position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out:
		fade_out(delta)

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
		fade_out_complete()
	else:
		$Flash.modulate.a += delta

func fade_out_complete() -> void:
	if GameState.player_node:
		GameState.player_node.process_mode = Node.PROCESS_MODE_INHERIT
		GameState.player_node.visible = true
	GameState.change_scene("TutorialScene")

func toggle_dyslexic_mode(val: bool) -> void:
	pass # Just here to not throw an error

func _on_start_button_pressed() -> void:
	# TODO: Add a delay/fade here
	# TODO: Reset player's tutorial/game state progress
	$AudioStreamPlayer.play()
	start_fade_out()


func _on_options_button_pressed() -> void:
	$AudioStreamPlayer.play()
	GameState.open_options_menu()
	# $OptionsMenuScene.show_menu()


func _on_credits_button_pressed() -> void:
	$AudioStreamPlayer.play()
	$CreditsMenu.show_menu()


func _on_quit_button_pressed() -> void:
	$AudioStreamPlayer.play()
	get_tree().quit()
	pass # Replace with function body.
