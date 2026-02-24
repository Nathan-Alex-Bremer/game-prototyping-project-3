extends Node2D

class_name Journal

var progress: float = 0
@export var pages: Dictionary[StringName, Node]
var page_names: Array[StringName] # This is so dumb and so ugly
var active_page: int = 0
var open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# GameState.connect("StateFound", on_state_found)
	# Building out our list of pages to iterate around
	for page in pages:
		page_names.append(page)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_state_found(creature_type: StringName, found_state: StringName, times_found: int) -> void:
	print("On state found")
	pages[creature_type].on_state_found(found_state, times_found)

func update_progress() -> void:
	# Entirely because it'd get annoying otherwise
	if progress >= 98:
		progress = 100
	$Progress.text = "Progress: " + str(int(progress)) + "%"
	
func toggle_opened() -> void:
	print("Toggle opened")
	pages[page_names[active_page]].toggle_opened()
	open = not open
	if open == false:
		pages[page_names[active_page]].clear_update_labels()
	# self.visible = (not self.visible)

func change_page(forward: bool) -> void:
	# Hides current page, shows next/previous page depending on direction
	if forward:
		if active_page >= (page_names.size() - 1):
			return
		pages[page_names[active_page]].toggle_opened()
		active_page += 1
		pages[page_names[active_page]].toggle_opened()
	else:
		if active_page <= 0:
			return
		pages[page_names[active_page]].toggle_opened()
		active_page -= 1
		pages[page_names[active_page]].toggle_opened()
