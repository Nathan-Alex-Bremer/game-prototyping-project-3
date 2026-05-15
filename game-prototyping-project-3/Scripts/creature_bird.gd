extends Creature
class_name Bird

# This is such an ugly way to handle this
func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if velocity.length() > 0:
		if not $WalkAudioStreamPlayer2D.playing and not is_dragging:
			$WalkAudioStreamPlayer2D.play()
