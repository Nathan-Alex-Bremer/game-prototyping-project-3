extends Creature
class_name Predator

var rain_timer: float = 3
var rain_timer_max: float = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	
	rain_timer -= delta
	
	# If raining, take away 1 HP every 5 seconds or so
	if rain_timer <= 0:
		if GameState.raining and blackboard.entered_cover == 0:
			change_hit_points(-1)
		rain_timer = rain_timer_max
