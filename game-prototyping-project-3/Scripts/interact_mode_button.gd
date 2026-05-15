extends Button


func _make_custom_tooltip(for_text: String) -> Object:
	
	var tooltip = preload("res://Scenes/InteractModeTooltip.tscn").instantiate()
	tooltip.text = for_text
	print(for_text)
	return tooltip
