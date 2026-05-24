extends Node2D
class_name CreditsMenu

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func show_menu() -> void:
	# visible = true
	active = true
	visible = true
	$AnimationPlayer.play("slide_in")

func hide_menu() -> void:
	# visible = false
	active = false
	$AnimationPlayer.play("slide_out")


func _on_back_button_pressed() -> void:
	$AudioStreamPlayer.play()
	hide_menu()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slide_out":
		visible = false
