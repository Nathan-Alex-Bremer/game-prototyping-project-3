extends Blackboard

class_name BlackboardFrog

# Blackboard for "predator" creature (no design yet)

# Hopping
var hop_timer: float = 0
@export var hop_timer_max: float = 1
var is_hopping: bool = true
var stopped: bool = false
var hop_velocity: Vector2
var hop_sprite: Texture2D
@export var still_sprite: Texture2D

func _ready() -> void:
	hop_timer = hop_timer_max

func initialize_hopping(hop_vel: Vector2, hop_spr: Texture2D) -> void:
	hop_timer = hop_timer_max
	is_hopping = true
	stopped = false
	hop_velocity = hop_vel
	hop_sprite = hop_spr
