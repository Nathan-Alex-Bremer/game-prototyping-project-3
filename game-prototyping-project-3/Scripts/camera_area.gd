extends Area2D

class_name CameraArea

var camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = get_viewport().get_camera_2d()
	# position = DisplayServer.mouse_get_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = camera.get_global_mouse_position() - get_parent().position
	
	if $InteractSprite2D.visible:
		if GameState.in_interact_range:
			$InteractSprite2D.modulate = Color(0, 1, 0, 0.6)
		else:
			$InteractSprite2D.modulate = Color(1, 0, 0, 0.6)
	# position = DisplayServer.mouse_get_position() - Vector2i(700, 470)
	# print(position)

func set_camera_crosshair_visible(val: bool) -> void:
	$Sprite2D.visible = val
	
func get_flash() -> Sprite2D:
	return $Flash

func set_interact_marker_visible(val: bool) -> void:
	$InteractSprite2D.visible = val
