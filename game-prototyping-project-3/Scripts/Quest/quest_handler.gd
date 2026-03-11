extends Node

class_name QuestHandler

# Variables
var current_quest: Quest = null
var selected_quest: Quest = null

var menu_open: bool = false

# Quest Label Spawning
@export var quest_label_object: PackedScene
@export var first_label_pos: Vector2
var label_pos: Vector2
@export var label_pos_move: float

@export var quest_list: Array[Quest]

var complete: bool = false

# Signals
signal new_quest()
signal quest_menu_opened()
signal quest_complete(quest: Quest)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_quest_menu() -> void:
	# TODO: Ugly! Figure out a better way to do this!
	if menu_open:
		hide_quest_info()
		hide_quest_menu()
	else:
		show_quest_menu()
	
func show_quest_menu() -> void:
	menu_open = true
	GameState.player_in_quest_menu = true # A bit hacky, but solves the issue of the quest menu staying down
	quest_menu_opened.emit()
	if complete:
		show_complete_quest()
	
	# Check which quests are available, display those which are
	label_pos = first_label_pos # Reset position to add label pos to
	for quest in quest_list:
		if quest.check_available():
			var new_quest_label = quest_label_object.instantiate()
			new_quest_label.quest = quest
			new_quest_label.quest_name = quest.quest_name
			new_quest_label.set_label()
			new_quest_label.position = label_pos
			new_quest_label.connect("quest_label_clicked", on_quest_label_clicked)
			$QuestMenu/QuestLabels.add_child(new_quest_label)
			label_pos.y += label_pos_move # Move position to spawn down
	
	if current_quest:
		$QuestMenu/ActiveQuestLabel.text = "ACTIVE QUEST: " + current_quest.quest_name + " (" + current_quest.calculate_progress() + ")"
	
	$QuestMenu.visible = true

func hide_quest_menu() -> void:
	menu_open = false
	$QuestMenu.visible = false
	GameState.player_in_quest_menu = false # A bit hacky, but solves the issue of the quest menu flag not updating correctly if a button is clicked
	
	for quest in quest_list:
		if quest.newly_available == 1:
			quest.newly_available = 2 # Mark quest as not newly available anymore
	
	for n in $QuestMenu/QuestLabels.get_children():
		$QuestMenu/QuestLabels.remove_child(n)
		n.queue_free()
	
func show_quest_info() -> void:
	
	$QuestInfo/Title.text = selected_quest.quest_name
	$QuestInfo/Description.text = selected_quest.description
	$QuestInfo/Reward.text = selected_quest.reward_desc
	$QuestInfo.visible = true

func hide_quest_info() -> void:
	$QuestInfo.visible = false
	
func on_quest_label_clicked(quest) -> void:
	selected_quest = quest
	
	show_quest_info()

func update_quest(creature: Creature, state_name: StringName) -> void:
	check_new_availability()
	
	if not current_quest:
		return
	var state_progress = current_quest.update_progress(creature, state_name)
	if state_progress == 2:
		complete_quest()

# FIre out signal to show icon if new quest is available
func check_new_availability() -> void:
	for quest in quest_list:
		if quest.check_available() and quest.newly_available == 1:
			new_quest.emit()

func complete_quest() -> void:
	# Tell player observer to show icon
	# Mark current quest as complete
	complete = true
	quest_complete.emit(current_quest)
	pass

func show_complete_quest() -> void:
	$QuestComplete/Reward.text = current_quest.reward_desc
	$QuestComplete/Thanks.text = current_quest.reward_thanks
	$QuestComplete.visible = true
	
func _on_accept_button_pressed() -> void:
	# TODO: What to do if player selects a quest while one is active
	if current_quest:
		current_quest.pause_quest()
	current_quest = selected_quest
	current_quest.start_quest()
	selected_quest = null
	hide_quest_info()
	hide_quest_menu()

func _on_reject_button_pressed() -> void:
	selected_quest = null
	hide_quest_info()


func _on_reward_exit_button_pressed() -> void:
	current_quest = null
	complete = false
	$QuestMenu/ActiveQuestLabel.text = "ACTIVE QUEST: NONE"
	$QuestComplete.visible = false
