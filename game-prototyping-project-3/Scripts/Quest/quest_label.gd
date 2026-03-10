extends Node

class_name QuestLabel

var quest: Quest
var quest_name: StringName

# signals
signal quest_label_clicked(quest)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_label() -> void:
	$Label.text = quest_name

# Quest button
func _on_button_pressed() -> void:
	quest_label_clicked.emit(quest)
