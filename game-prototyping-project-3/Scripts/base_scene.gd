extends Node2D

# @export var player: PlayerObserver

@export var timer_count: float = 60
var timer: float



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	timer = timer_count
	
	# Instantiate a player observer
	var new_player = GameState.player_scene.instantiate()
	new_player.connect("CapturedState", on_capture_state)
	add_child(new_player)
	
	# Instantiate a creature
	var new_creature = GameState.creature_scene.instantiate()
	var random_point = Vector2(randf_range(0, GameState.screen_size.x), randf_range(0, GameState.screen_size.y))
	new_creature.position = random_point
	add_child(new_creature)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer -= delta
	
	if timer <= 0:
		# TODO: Add check for max food amount here
		spawn_food()
		# Reset timer
		timer = timer_count

func spawn_food() -> void:
	var random_point = Vector2(randf_range(0, GameState.screen_size.x), randf_range(0, GameState.screen_size.y))
	
	# Instantiate food object
	var new_food = GameState.food_scene.instantiate()
	new_food.position = random_point
	add_child(new_food)

func on_capture_state(state: StringName) -> void:
	for known_state in GameState.found_states:
		if known_state == state and GameState.found_states[state] == false:
			GameState.found_states[state] = true
			print("Found State: " + state)
			return
