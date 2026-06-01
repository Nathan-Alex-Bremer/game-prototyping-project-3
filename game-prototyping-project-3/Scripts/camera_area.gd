extends Area2D

class_name CameraArea

var camera

signal toggle_photo_mode(val: bool)

# Variables
@export var check_mode_icon: Texture2D
@export var place_food_mode_icon: Texture2D
@export var pet_mode_icon: Texture2D
@export var poke_mode_icon: Texture2D
@export var drag_mode_icon: Texture2D
@export var horn_mode_icon: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	# position = DisplayServer.mouse_get_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = camera.get_global_mouse_position() - get_parent().position
	
	if $InteractSprite2D.visible:
		if GameState.in_interact_range:
			$InteractSprite2D.modulate = Color(0, 1, 0, 0.5)
			$InteractSprite2D/NoInteract.visible = false
		else:
			$InteractSprite2D.modulate = Color(1, 0, 0, 0.5)
			$InteractSprite2D/NoInteract.visible = true
	# position = DisplayServer.mouse_get_position() - Vector2i(700, 470)
	# print("Mouse Position: " + str(position))
	
	
	
	# UGHHHHH
	if GameState.dialogue_open:
		if $Sprite2D.visible:
			print("Toggle off")
			toggle_photo_mode.emit(false)
		
	elif (-164 <= position.x and position.x <= 164) and (-350 <= position.y and position.y <= -278):
		toggle_photo_mode.emit(false)
	
	else:
		toggle_photo_mode.emit(true)

func set_camera_crosshair_visible(val: bool) -> void:
	$Sprite2D.visible = val
	
func get_flash() -> Sprite2D:
	return $Flash

func set_interact_marker_visible(val: bool) -> void:
	$InteractSprite2D.visible = val
	
func set_food_count_visible(val: bool) -> void:
	$FoodCountLabel.visible = val

func set_food_count_val(val: int) -> void:
	$FoodCountLabel.text = str(val)

func set_interact_sprite(val: GameState.INTERACT_MODES) -> void:
	match val:
		GameState.INTERACT_MODES.CHECK:
			$InteractSprite2D.texture = check_mode_icon
		GameState.INTERACT_MODES.PLACE_FOOD:
			$InteractSprite2D.texture = place_food_mode_icon
		GameState.INTERACT_MODES.PET:
			$InteractSprite2D.texture = pet_mode_icon
		GameState.INTERACT_MODES.POKE:
			$InteractSprite2D.texture = poke_mode_icon
		GameState.INTERACT_MODES.DRAG:
			$InteractSprite2D.texture = drag_mode_icon
		GameState.INTERACT_MODES.HORN:
			$InteractSprite2D.texture = horn_mode_icon
