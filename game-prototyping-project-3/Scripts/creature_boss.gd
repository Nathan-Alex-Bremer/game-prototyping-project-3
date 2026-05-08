extends Creature
class_name Boss

func _process(delta: float) -> void:
	# Can't believe I need to copy this over just so boss won't autoleave when hungry even if satisfied
	time_passed += delta
	# TODO: Make the labels update constantly, if you feel like it
		
	if time_passed > 5:
		# print("Hunger: " + str(hunger))
		# print("Feisty: " + str(feisty))
		# print("Tired: " + str(tired))
		time_passed = 0
	
	# Poison ticks
	if is_poisoned:
		poison_damage_timer -= delta
		if poison_damage_timer <= 0:
			poison_damage()
	
	if (is_leaving) and not $VisibleOnScreenNotifier2D.is_on_screen() and not blackboard.hidden:
		Leaving.emit(type, creature_name)
		
		# Set checking creature to null, if applicable
		if GameState.selected_creature == self:
			GameState.selected_creature = null
		
		# Erase
		GameState.existing_creatures.erase(self)
		GameState.num_existing_creatures -= 1
		queue_free()
		
# This is such an ugly way to handle this
func _physics_process(delta: float) -> void:
	# move_and_slide()
	# TODO: See how this feels, maybe replace with inability to drag
	if is_dragging:
		position = lerp(position, get_global_mouse_position(), 0.05)
	
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
	
	if velocity.length() > 0:
		if not $WalkAudioStreamPlayer2D.playing and not is_dragging:
			$WalkAudioStreamPlayer2D.play()

func set_satisfied() -> void:
	if blackboard is BlackboardBoss:
		blackboard.satisfied = true

func set_quest_completed() -> void:
	if blackboard is BlackboardBoss:
		blackboard.quest_completed = true
