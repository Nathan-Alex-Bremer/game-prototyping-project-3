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
	# position = DisplayServer.mouse_get_position() - Vector2i(700, 470)
	# print(position)

func get_flash() -> Sprite2D:
	return $Flash
