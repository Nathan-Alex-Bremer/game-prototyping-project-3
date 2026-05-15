extends Camera2D

# Tutorial by Gwizz - thank you!
@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

var shake_strength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called to apply shake
func apply_shake(multiplier):
	shake_strength = randomStrength * multiplier

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Each frame calls a gradually decreasing camera shake
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0.0, shakeFade * delta)
		
		offset = random_offset()
	else:
		# Resets offset just to be safe
		offset = Vector2(0, 0)

# Calculates random offset for shakes
func random_offset() -> Vector2:
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
