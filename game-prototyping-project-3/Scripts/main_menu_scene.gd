extends Node2D

# Variables
var fading_out_1: bool = false
var fading_out_2: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameState.player_node:
		GameState.player_node.process_mode = Node.PROCESS_MODE_DISABLED
		GameState.player_node.visible = false
		GameState.player_node.position = Vector2(0, 0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out_1:
		fade_out_1(delta)
	if fading_out_2:
		fade_out_2(delta)
		
	if Input.is_action_just_pressed("capture_screen"):
		
		# Advance text if dialogue screen is open
		if $Opening.visible:
			start_fade_out_2()

func start_fade_out_1() -> void:
	print("Start fade out")
	
	# Prevent pressing buttons
	for child in find_children("", "Button", true, true):
		if child is Button:
			child.process_mode = Node.PROCESS_MODE_DISABLED
	GameState.input_allowed = false
	fading_out_1 = true

func fade_out_1(delta: float) -> void:
	if $Flash.modulate.a + delta >= 1:
		print("Fade out complete")
		$Flash.modulate.a = 1
		fading_out_1 = false
		# signal
		fade_out_1_complete()
	else:
		$Flash.modulate.a += delta

func start_fade_out_2() -> void:
	print("Start fade out")
	GameState.input_allowed = false
	fading_out_2 = true

func fade_out_2(delta: float) -> void:
	if $Flash2.modulate.a + delta >= 1:
		print("Fade out complete")
		$Flash2.modulate.a = 1
		fading_out_2 = false
		# signal
		fade_out_2_complete()
	else:
		$Flash2.modulate.a += delta

func fade_out_1_complete() -> void:
	$Opening.visible = true
	$Opening/OpeningCrawl/AnimationPlayer.play("opening_crawl")

func fade_out_2_complete() -> void:
	$Opening/OpeningCrawl/AnimationPlayer.stop()
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
	start_fade_out_1()


func _on_options_button_pressed() -> void:
	$AudioStreamPlayer.play()
	GameState.open_options_menu()
	# $OptionsMenuScene.show_menu()


func _on_credits_button_pressed() -> void:
	$AudioStreamPlayer.play()
	$CreditsMenu.show_menu()


func _on_quit_button_pressed() -> void:
	$AudioStreamPlayer.play()
	# get_tree().quit()
	pass # Replace with function body.
