extends Node2D
class_name InteractBar


# Signals (mostly for mouse control)

# DEPRECATED
signal InteractBarMouseEntered()
signal InteractBarMouseExited()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func unlock_interact_mode(mode: GameState.INTERACT_MODES) -> void:
	match mode:
		GameState.INTERACT_MODES.CHECK:
			pass
		GameState.INTERACT_MODES.PLACE_FOOD:
			$PlaceFood/LockButton.disabled = true
			$PlaceFood/LockButton.visible = false
			$PlaceFood/Button.disabled = false
		GameState.INTERACT_MODES.PET:
			$Pet/LockButton.disabled = true
			$Pet/LockButton.visible = false
			$Pet/Button.disabled = false
		GameState.INTERACT_MODES.POKE:
			$Poke/LockButton.disabled = true
			$Poke/LockButton.visible = false
			$Poke/Button.disabled = false
		GameState.INTERACT_MODES.DRAG:
			$Drag/LockButton.disabled = true
			$Drag/LockButton.visible = false
			$Drag/Button.disabled = false
		GameState.INTERACT_MODES.HORN:
			$Horn/LockButton.disabled = true
			$Horn/LockButton.visible = false
			$Horn/Button.disabled = false

func update_highlight(prev_mode: GameState.INTERACT_MODES, new_mode: GameState.INTERACT_MODES) -> void:
	
	# Remove old highlight
	match prev_mode:
		GameState.INTERACT_MODES.CHECK:
			$Check/Highlight.visible = false
		GameState.INTERACT_MODES.PLACE_FOOD:
			$PlaceFood/Highlight.visible = false
		GameState.INTERACT_MODES.PET:
			$Pet/Highlight.visible = false
		GameState.INTERACT_MODES.POKE:
			$Poke/Highlight.visible = false
		GameState.INTERACT_MODES.DRAG:
			$Drag/Highlight.visible = false
		GameState.INTERACT_MODES.HORN:
			$Horn/Highlight.visible = false

	match new_mode:
		GameState.INTERACT_MODES.CHECK:
			$Check/Highlight.visible = true
		GameState.INTERACT_MODES.PLACE_FOOD:
			$PlaceFood/Highlight.visible = true
		GameState.INTERACT_MODES.PET:
			$Pet/Highlight.visible = true
		GameState.INTERACT_MODES.POKE:
			$Poke/Highlight.visible = true
		GameState.INTERACT_MODES.DRAG:
			$Drag/Highlight.visible = true
		GameState.INTERACT_MODES.HORN:
			$Horn/Highlight.visible = true


func _on_check_button_pressed() -> void:
	if GameState.mode == GameState.INTERACT_MODES.CHECK:
		return
		
	var prev_mode = GameState.mode
	GameState.update_interact_mode(GameState.INTERACT_MODES.CHECK)
	
	update_highlight(prev_mode, GameState.mode)


func _on_place_food_button_pressed() -> void:
	if GameState.mode == GameState.INTERACT_MODES.PLACE_FOOD:
		return
		
	var prev_mode = GameState.mode
	GameState.update_interact_mode(GameState.INTERACT_MODES.PLACE_FOOD)
	
	update_highlight(prev_mode, GameState.mode)


func _on_pet_button_pressed() -> void:
	if GameState.mode == GameState.INTERACT_MODES.PET:
		return
		
	var prev_mode = GameState.mode
	GameState.update_interact_mode(GameState.INTERACT_MODES.PET)
	
	update_highlight(prev_mode, GameState.mode)


func _on_poke_button_pressed() -> void:
	if GameState.mode == GameState.INTERACT_MODES.POKE:
		return
		
	var prev_mode = GameState.mode
	GameState.update_interact_mode(GameState.INTERACT_MODES.POKE)
	
	update_highlight(prev_mode, GameState.mode)


func _on_drag_button_pressed() -> void:
	if GameState.mode == GameState.INTERACT_MODES.DRAG:
		return
		
	var prev_mode = GameState.mode
	GameState.update_interact_mode(GameState.INTERACT_MODES.DRAG)
	
	update_highlight(prev_mode, GameState.mode)


func _on_horn_button_pressed() -> void:
	if GameState.mode == GameState.INTERACT_MODES.HORN:
		return
		
	var prev_mode = GameState.mode
	GameState.update_interact_mode(GameState.INTERACT_MODES.HORN)
	
	update_highlight(prev_mode, GameState.mode)


func _on_area_2d_mouse_entered() -> void:
	InteractBarMouseEntered.emit()


func _on_area_2d_mouse_exited() -> void:
	InteractBarMouseExited.emit()
