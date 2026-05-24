extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameState.player_node:
		GameState.player_node.process_mode = Node.PROCESS_MODE_DISABLED
		GameState.player_node.visible = false
		GameState.player_node.position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	# TODO: Add a delay/fade here
	# TODO: Reset player's tutorial/game state progress
	$AudioStreamPlayer.play()
	if GameState.player_node:
		GameState.player_node.process_mode = Node.PROCESS_MODE_INHERIT
		GameState.player_node.visible = true
	GameState.change_scene("TutorialScene")


func _on_options_button_pressed() -> void:
	$AudioStreamPlayer.play()
	$OptionsMenuScene.show_menu()


func _on_credits_button_pressed() -> void:
	$AudioStreamPlayer.play()
	$CreditsMenu.show_menu()


func _on_quit_button_pressed() -> void:
	$AudioStreamPlayer.play()
	pass # Replace with function body.
