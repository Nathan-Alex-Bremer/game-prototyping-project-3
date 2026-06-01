extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = GameState.player_scene.instantiate()
	GameState.player_node = player
	var options_menu = GameState.options_menu_scene.instantiate()
	GameState.options_menu_node = options_menu
	# player.connect_camera_area(camera_area)
	add_child(player)
	add_child(options_menu)
	
	GameState.main_scene = self
	GameState.set_initial_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_high_contrast(val: bool) -> void:
	if val == true:
		$WorldEnvironment.environment.adjustment_contrast = 1.5
	else:
		$WorldEnvironment.environment.adjustment_contrast = 1.0
		
func open_options_menu(pos: Vector2) -> void:
	$OptionsMenuScene.position = pos
	$OptionsMenuScene.show_menu()

func close_options_menu() -> void:
	$OptionsMenuScene.hide_menu()
