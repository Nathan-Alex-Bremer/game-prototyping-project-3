extends Creature
class_name Frog

@export var tongue: Line2D

var rain_timer: float = 5
var rain_timer_max: float = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	
	rain_timer -= delta
	
	# If NOT raining, take away 1 HP every 5 seconds or so
	if rain_timer <= 0:
		if not GameState.raining:
			change_hit_points(-1)
		rain_timer = rain_timer_max
		
# This is such an ugly way to handle this
func _physics_process(delta: float) -> void:
	# move_and_slide()
	if is_dragging:
		position = get_global_mouse_position()
	
	if blackboard is BlackboardFrog:
		if not blackboard.stopped:
			var collision_info = move_and_collide(velocity * delta)
			if collision_info:
				velocity = velocity.bounce(collision_info.get_normal())
	
	## Reverse x-value movement if going out of bounds
	#if position.x >= GameState.screen_size.x or position.x <= 0:
		#velocity.x *= -1
	## Reverse y-value movement if going out of bounds
	#if position.y >= GameState.screen_size.y or position.y <= 0:
		#velocity.y *= -1
	
	# TODO: Maybe instead cause the player to stop dragging when the creature re-enters after the player lets go of click, instead?
	if is_dragging and not GameState.in_interact_range and GameState.mode == GameState.INTERACT_MODES.DRAG:
		is_dragging = false
		play_sound(place_sound)
	
	# This is ugly but it preserves direction when velocity = 0
	if velocity.x > 0:
		$Sprite2D.flip_h = true
		$Tongue.points[0].x = 37
	elif velocity.x < 0:
		$Sprite2D.flip_h = false
		$Tongue.points[0].x = -37
	# $Sprite2D.flip_h = (velocity.x > 0)

func hop_switch() -> void:
	if blackboard is BlackboardFrog:
		blackboard.hop_timer = blackboard.hop_timer_max
					
		if blackboard.stopped:
			blackboard.stopped = false
			# velocity = blackboard.hop_velocity
			$Sprite2D.texture = blackboard.hop_sprite
			$WalkAudioStreamPlayer2D.play()
		else:
			blackboard.stopped = true
			# velocity = Vector2.ZERO
			$Sprite2D.texture = blackboard.still_sprite
			
func play_hop_sound() -> void:
	# This is so dumb but it's probably the most convenient way to play a hop sound on starting movement
	$WalkAudioStreamPlayer2D.play()

func get_tongue() -> Line2D:
	return tongue
