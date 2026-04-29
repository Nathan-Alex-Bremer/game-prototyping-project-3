extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var player = GameState.player_scene.instantiate()
	GameState.player_node = player
	# player.connect_camera_area(camera_area)
	add_child(player)
	
	GameState.main_scene = self
	GameState.set_initial_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
