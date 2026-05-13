extends Node2D

class_name JournalPage

var found_states_creature: float = 0
var progress: float = 0
@export var total_states: float = 0

# Variables
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var completion_star: Sprite2D = $Container/CompletionStar

# Signals
signal slide_out_complete()

func _ready() -> void:
	animation_player.connect("animation_finished", on_animation_finished)

func on_state_found(found_state: StringName, times_found: int) -> void:
	pass

#func update_progress() -> void:
	## Entirely because it'd get annoying otherwise
	#$Progress.text = "Progress: " + str(int((progress / total_states) * 100)) + "%"
	
func toggle_opened(val: bool) -> void:
	print("Page toggle opened")
	self.visible = val
	
func clear_update_labels() -> void:
	pass
	
func toggle_star() -> void:
	print("Toggling star!")
	completion_star.visible = true

func play_slide_in() -> void:
	print("Playing slide in")
	animation_player.play("slide_in")
	
func play_slide_out() -> void:
	print("Playing slide out")
	animation_player.play("slide_out")

func on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slide_out":
		slide_out_complete.emit()
