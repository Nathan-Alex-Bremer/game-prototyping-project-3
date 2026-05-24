extends Node2D

# Variables

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func show_menu() -> void:
	visible = true
	active = true
	$AnimationPlayer.play("slide_in")

func hide_menu() -> void:
	# visible = false
	active = false
	$AnimationPlayer.play("slide_out")


func _on_volume_bgm_drag_ended(value_changed: bool) -> void:
	GameState.edit_bgm_volume($VolumeBGM.value)
	$AudioStreamPlayer.play()


func _on_volume_sfx_drag_ended(value_changed: bool) -> void:
	GameState.edit_sfx_volume($VolumeSFX.value)
	$AudioStreamPlayer.play()


func _on_high_contrast_button_toggled(toggled_on: bool) -> void:
	$AudioStreamPlayer.play()
	GameState.dyslexic_mode_queued = true
	GameState.dyslexic_mode_val = toggled_on
	pass # Replace with function body.


func _on_dyslexic_mode_button_toggled(toggled_on: bool) -> void:
	GameState.high_contrast_mode_queued = true
	GameState.high_contrast_mode_val = toggled_on
	$AudioStreamPlayer.play()


func _on_disable_flash_button_toggled(toggled_on: bool) -> void:
	GameState.flash_disabled = toggled_on
	$AudioStreamPlayer.play()


func _on_back_button_pressed() -> void:
	$AudioStreamPlayer.play()
	hide_menu()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slide_out":
		visible = false
