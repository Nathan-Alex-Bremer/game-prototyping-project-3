extends Sprite2D

var fading_out: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out:
		if modulate.a + delta >= 1:
			print("Fade out complete")
			modulate.a = 1
			fading_out = false
		else:
			modulate.a += delta


func _on_exit_button_pressed() -> void:
	get_tree().paused = false
	modulate.a = 0
	GameState.change_scene("main_menu_scene")
