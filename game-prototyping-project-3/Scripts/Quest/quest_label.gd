extends Node

class_name QuestLabel

var quest: Quest
var quest_name: StringName

# signals
signal quest_label_clicked(quest)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Handling dyslexic mode
	var dyslexic_font = load("res://Fonts/OpenDyslexic-Regular.otf")
	
	if GameState.dyslexic_mode:
		
		for child in find_children("", "Label", true, true):
			if child is Label:
				
				if child.label_settings.font != dyslexic_font:
					child.label_settings.font = dyslexic_font
					child.label_settings.font_size -= 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_label() -> void:
	$Label.text = quest_name

# Quest button
func _on_button_pressed() -> void:
	quest_label_clicked.emit(quest)
