extends Node2D

class_name Journal

var progress: float = 0

# Instantiating journal page scenes, so resetting is easier
var reference_page = preload("res://Scenes/JournalPageReference.tscn")
var creature_page = preload("res://Scenes/JournalPageCreature.tscn")
var predator_page = preload("res://Scenes/JournalPagePredator.tscn")
var plantcreature_page = preload("res://Scenes/JournalPagePlantCreature.tscn")
var frog_page = preload("res://Scenes/JournalPageFrog.tscn")
var bird_page = preload("res://Scenes/JournalPageBird.tscn")
var boss_page = preload("res://Scenes/JournalPageBoss.tscn")

var tutorialcreature_page = preload("res://Scenes/JournalPageTutorialCreature.tscn")

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
	pages["Reference"] = reference_page.instantiate()
	call_deferred("add_child", pages["Reference"])
	pages["Creature"] = creature_page.instantiate()
	call_deferred("add_child", pages["Creature"])
	pages["Predator"] = predator_page.instantiate()
	call_deferred("add_child", pages["Predator"])
	pages["PlantCreature"] = plantcreature_page.instantiate()
	call_deferred("add_child", pages["PlantCreature"])
	pages["Frog"] = frog_page.instantiate()
	call_deferred("add_child", pages["Frog"])
	pages["Bird"] = bird_page.instantiate()
	call_deferred("add_child", pages["Bird"])
	pages["Boss"] = boss_page.instantiate()
	call_deferred("add_child", pages["Boss"])
	
	tutorial_page = tutorialcreature_page.instantiate()
	call_deferred("add_child", tutorial_page)
	
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
	page_names.append("Boss")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func reset_state() -> void:
	progress = 0
	
	active_page = 0
	open = false
	
	# Reset all pages
	pages.clear()
	pages["Reference"] = reference_page.instantiate()
	call_deferred("add_child", pages["Reference"])
	pages["Creature"] = creature_page.instantiate()
	call_deferred("add_child", pages["Creature"])
	pages["Predator"] = predator_page.instantiate()
	call_deferred("add_child", pages["Predator"])
	pages["PlantCreature"] = plantcreature_page.instantiate()
	call_deferred("add_child", pages["PlantCreature"])
	pages["Frog"] = frog_page.instantiate()
	call_deferred("add_child", pages["Frog"])
	pages["Bird"] = bird_page.instantiate()
	call_deferred("add_child", pages["Bird"])
	pages["Boss"] = boss_page.instantiate()
	call_deferred("add_child", pages["Boss"])
	
	tutorial_page = tutorialcreature_page.instantiate()
	call_deferred("add_child", tutorial_page)
	
	toggle_dyslexic_mode(GameState.dyslexic_mode)

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

func is_new_creature(creature_type: StringName) -> bool:
	if GameState.tutorial_mode:
		if tutorial_page.progress == 0:
			return true
		return false
	if pages[creature_type].progress == 0:
		return true
	return false

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	if progress >= 98:
		progress = 100
	$Progress.text = "Progress: " + str(int(progress)) + "%"
	
func toggle_opened() -> void:
	print("Toggle opened")
	# For tutorial mode, open the designated tutorial page
	if GameState.tutorial_mode:
		open = not open
		if open == false:
			tutorial_page.clear_update_labels()
			tutorial_page.play_slide_out()
			play_sound(close_journal_sound)
			
			# If the journal has new info during the tutorial, update tutorial progress on close
			if tutorial_page.progress > 0:
				tutorial_close.emit()
		else:
			play_sound(open_journal_sound)
			tutorial_page.toggle_opened(true)
			tutorial_page.play_slide_in()
			
		
		return # I don't want an else statement here because it'd look ugly
	
	# pages[page_names[active_page]].toggle_opened()
	open = not open
	if open == false:
		pages[page_names[active_page]].clear_update_labels()
		pages[page_names[active_page]].play_slide_out()
		play_sound(close_journal_sound)
		
		# Hide arrows
		$RightArrow.visible = false
		$LeftArrow.visible = false
	else:
		pages[page_names[active_page]].toggle_opened(true)
		pages[page_names[active_page]].play_slide_in()
		play_sound(open_journal_sound)
		
		
		# Show arrows
		$RightArrow.visible = (active_page < (page_names.size() - 1))
		$LeftArrow.visible = (active_page > 0)
		
	# self.visible = (not self.visible)

func slide_out_complete() -> void:
	print("Slide out complete")
	if GameState.tutorial_mode:
		if not open:
			tutorial_page.toggle_opened(false)
		return
	if not open:
		pages[page_names[active_page]].toggle_opened(false)
	
func change_page(forward: bool) -> void:
	
	# Unnecessary for tutorial
	if GameState.tutorial_mode:
		return
		
	# Hides current page, shows next/previous page depending on direction
	if forward:
		if active_page >= (page_names.size() - 1):
			return
		pages[page_names[active_page]].toggle_opened(false)
		active_page += 1
		pages[page_names[active_page]].toggle_opened(true)
		play_sound(change_page_sound)
		
		if active_page >= (page_names.size() - 1):
			$RightArrow.visible = false
		$LeftArrow.visible = true
	else:
		if active_page <= 0:
			return
		pages[page_names[active_page]].toggle_opened(false)
		active_page -= 1
		pages[page_names[active_page]].toggle_opened(true)
		play_sound(change_page_sound)
		
		if active_page <= 0:
			$LeftArrow.visible = false
		$RightArrow.visible = true
		
func toggle_star(selected_page: StringName) -> void:
	pages[selected_page].toggle_star()
		
# Audio

func play_sound(sound: AudioStream) -> void:
	audio_player.stream = sound
	audio_player.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
	audio_player.play()


func _on_left_button_pressed() -> void:
	change_page(false)


func _on_right_button_pressed() -> void:
	change_page(true)

func toggle_dyslexic_mode(val: bool) -> void:
	print("Toggle dyslexic mode - journal")
	for page in pages:
		pages[page].toggle_dyslexic_mode(val)
