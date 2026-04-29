extends Node2D

class_name Journal

var progress: float = 0
@export var pages: Dictionary[StringName, Node]
var page_names: Array[StringName] # This is so dumb and so ugly
var active_page: int = 0
var open = false

# Tutorial
@export var tutorial_page: Node2D

# Audio
@export_group("Sounds")

@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

@export var new_unlock_sound: AudioStream

@export var open_journal_sound: AudioStream
@export var close_journal_sound: AudioStream
@export var change_page_sound: AudioStream

# Signals

signal tutorial_close()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# GameState.connect("StateFound", on_state_found)
	# Building out our list of pages to iterate around
	#for page in pages:
		#page_names.append(page)
	page_names.append("Reference")
	page_names.append("Creature")
	page_names.append("Predator")
	page_names.append("PlantCreature")
	page_names.append("Frog")
	page_names.append("Bird")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_state_found(creature_type: StringName, found_state: StringName, times_found: int) -> void:
	
	# If tutorial mode, there's only one creature
	if GameState.tutorial_mode:
		play_sound(new_unlock_sound)
		tutorial_page.on_state_found(found_state, times_found)
		return
		
	print("On state found")
	# Play a little sound if a new creature has been found
	if pages[creature_type].progress == 0:
		play_sound(new_unlock_sound)
	pages[creature_type].on_state_found(found_state, times_found)

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	if progress >= 98:
		progress = 100
	$Progress.text = "Progress: " + str(int(progress)) + "%"
	
func toggle_opened() -> void:
	print("Toggle opened")
	# For tutorial mode, open the designated tutorial page
	if GameState.tutorial_mode:
		tutorial_page.toggle_opened()
		open = not open
		if open == false:
			tutorial_page.clear_update_labels()
			play_sound(close_journal_sound)
			
			# If the journal has new info during the tutorial, update tutorial progress on close
			if tutorial_page.progress > 0:
				tutorial_close.emit()
		else:
			play_sound(open_journal_sound)
		
		return # I don't want an else statement here because it'd look ugly
	
	pages[page_names[active_page]].toggle_opened()
	open = not open
	if open == false:
		pages[page_names[active_page]].clear_update_labels()
		play_sound(close_journal_sound)
	else:
		play_sound(open_journal_sound)
	# self.visible = (not self.visible)

func change_page(forward: bool) -> void:
	
	# Unnecessary for tutorial
	if GameState.tutorial_mode:
		return
		
	# Hides current page, shows next/previous page depending on direction
	if forward:
		if active_page >= (page_names.size() - 1):
			return
		pages[page_names[active_page]].toggle_opened()
		active_page += 1
		pages[page_names[active_page]].toggle_opened()
		play_sound(change_page_sound)
	else:
		if active_page <= 0:
			return
		pages[page_names[active_page]].toggle_opened()
		active_page -= 1
		pages[page_names[active_page]].toggle_opened()
		play_sound(change_page_sound)
		
func toggle_star(selected_page: StringName) -> void:
	pages[selected_page].toggle_star()
		
# Audio

func play_sound(sound: AudioStream) -> void:
	audio_player.stream = sound
	audio_player.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
	audio_player.play()
