extends Creature
class_name Boss

# This is such an ugly way to handle this
func _physics_process(delta: float) -> void:
	# move_and_slide()
	# TODO: See how this feels, maybe replace with inability to drag
	if is_dragging:
		position = lerp(position, get_global_mouse_position(), 0.1)
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	
	# Disengage dragging if creature leaves interact range, to avoid messes
	# TODO: Maybe instead cause the player to stop dragging when the creature re-enters after the player lets go of click, instead?
	if is_dragging and not GameState.in_interact_range and GameState.mode == GameState.INTERACT_MODES.DRAG:
		is_dragging = false
		play_sound(place_sound)
	
	## Reverse x-value movement if going out of bounds
	#if position.x >= GameState.screen_size.x or position.x <= 0:
		#velocity.x *= -1
	## Reverse y-value movement if going out of bounds
	#if position.y >= GameState.screen_size.y or position.y <= 0:
		#velocity.y *= -1
	
	# This is ugly but it preserves direction when velocity = 0
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	elif velocity.x < 0:
		$Sprite2D.flip_h = false
	# $Sprite2D.flip_h = (velocity.x > 0)
