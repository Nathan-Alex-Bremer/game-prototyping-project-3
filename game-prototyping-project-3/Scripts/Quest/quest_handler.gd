extends Node

class_name QuestHandler

# Variables
var current_quest: Quest = null
var selected_quest: Quest = null

var menu_open: bool = false

var final_reward_tease: bool = false

# Quest Label Spawning
@export var quest_label_object: PackedScene
@export var first_label_pos: Vector2
var label_pos: Vector2
@export var label_pos_move: float

@export var quest_list: Array[Quest]

var complete: bool = false

# Audio
@export_group("Sounds")

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_player_2: AudioStreamPlayer = $AudioStreamPlayer2

@export var open_sound: AudioStream
@export var close_sound: AudioStream

@export var button_click_sound: AudioStream
@export var quest_complete_sound: AudioStream

@export_group("")

# Signals
signal new_quest()
signal quest_menu_opened()
signal quest_started(quest: Quest)
signal quest_complete(quest: Quest)
signal quest_complete_popup(creature_type: StringName)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Flash.modulate.a = lerp($Flash.modulate.a, 0.0, 0.03)
	pass

func toggle_quest_menu() -> void:
	# TODO: Ugly! Figure out a better way to do this!
	if menu_open:
		$AnimationPlayer.play("slide_out")
		# Close QuestComplete and make sure to run all relevant code if the popup is open
		if $QuestComplete.visible:
			_on_reward_exit_button_pressed() 
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
	var quests_shown: int = 0
	for quest in quest_list:
		if quest.check_available() and quests_shown <= 4:
			var new_quest_label = quest_label_object.instantiate()
			new_quest_label.quest = quest
			new_quest_label.quest_name = quest.quest_name
			new_quest_label.set_label()
			new_quest_label.position = label_pos
			new_quest_label.connect("quest_label_clicked", on_quest_label_clicked)
			$QuestMenu/QuestLabels.add_child(new_quest_label)
			label_pos.y += label_pos_move # Move position to spawn down
			quests_shown += 1 # Prevent quests from going off the screen
	
	if current_quest:
		$QuestMenu/ActiveQuestLabel.text = "ACTIVE QUEST: " + current_quest.quest_name + " (" + current_quest.calculate_progress() + ")"
	
	$AnimationPlayer.play("slide_in")
	$QuestMenu.visible = true
	play_sound(open_sound, 1)
	

func hide_quest_menu() -> void:
	menu_open = false
	$QuestMenu.visible = false
	GameState.player_in_quest_menu = false # A bit hacky, but solves the issue of the quest menu flag not updating correctly if a button is clicked
	
	for quest in quest_list:
		if quest.newly_available == 1:
			# quest.newly_available = 2 # Mark quest as not newly available anymore
			pass
	
	for n in $QuestMenu/QuestLabels.get_children():
		$QuestMenu/QuestLabels.remove_child(n)
		n.queue_free()
	play_sound(close_sound, 1)
	
func show_quest_info() -> void:
	
	# Hacky way to get the final quest to have slightly different text
	# TODO: Test this!!!
	if GameState.completed_quests == 4 and not final_reward_tease:
		selected_quest.reward_desc += ", and...?"
		final_reward_tease = true
	
	$QuestInfo/Title.text = selected_quest.quest_name
	$QuestInfo/Description.text = selected_quest.description
	$QuestInfo/Task.text = selected_quest.task_desc
	$QuestInfo/Reward.text = selected_quest.reward_desc
	$QuestInfo.visible = true

func hide_quest_info() -> void:
	$QuestInfo.visible = false
	
func on_quest_label_clicked(quest) -> void:
	selected_quest = quest
	play_sound(button_click_sound, 2)
	
	show_quest_info()

func update_quest(creature: Creature, state_name: StringName) -> void:
	check_new_availability()
	
	if not current_quest:
		return
	var state_progress = current_quest.update_progress(creature, state_name)
	if state_progress == 2:
		complete_quest()

# Fire out signal to show icon if new quest is available
func check_new_availability() -> void:
	for quest in quest_list:
		if quest.check_available() and quest.newly_available == 1:
			new_quest.emit()
			quest.newly_available = 2 # Mark quest as not newly available anymore

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
	$Flash.modulate.a = 0.6
	play_sound(quest_complete_sound, 2)
	GameState.completed_quests += 1 # Keep track of number of ompleted quests
	
	if GameState.completed_quests == 5:
		GameState.unlock_horn()
	
# Audio

func play_sound(sound: AudioStream, player_num: int) -> void:
	# Separating sounds into two audio players to ensure things play - polyphony wasn't helping
	if player_num == 1:
		audio_player.stream = sound
		audio_player.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
		audio_player.play()
	else:
		audio_player_2.stream = sound
		audio_player_2.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
		audio_player_2.play()
	
func _on_accept_button_pressed() -> void:
	# TODO: What to do if player selects a quest while one is active
	if current_quest:
		current_quest.pause_quest()
	current_quest = selected_quest
	current_quest.start_quest()
	selected_quest = null
	$AnimationPlayer.play("slide_out")
	play_sound(button_click_sound, 2)
	quest_started.emit(current_quest)

func _on_reject_button_pressed() -> void:
	selected_quest = null
	hide_quest_info()
	play_sound(button_click_sound, 2)


func _on_reward_exit_button_pressed() -> void:
	quest_complete_popup.emit(current_quest.creature_type) # Signal to add star (moved to let signal be passed to the boss)
	current_quest = null
	complete = false
	$QuestMenu/ActiveQuestLabel.text = "ACTIVE QUEST: NONE"
	$QuestComplete.visible = false
	play_sound(button_click_sound, 2)
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "slide_out":
		hide_quest_info()
		hide_quest_menu()
