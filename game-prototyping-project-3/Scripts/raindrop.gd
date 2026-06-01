extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	var size = randf_range(0.7, 1.0)
	$Sprite2D.scale = Vector2(size, size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Sprite2D.modulate.a -= delta
	if $Sprite2D.modulate.a <= 0:
		queue_free()
