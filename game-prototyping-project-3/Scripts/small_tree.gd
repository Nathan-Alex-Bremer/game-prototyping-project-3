extends Node2D

class_name SmallTree

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimationPlayer.play("rustle_light")
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
		$AudioStreamPlayer2D.play()
