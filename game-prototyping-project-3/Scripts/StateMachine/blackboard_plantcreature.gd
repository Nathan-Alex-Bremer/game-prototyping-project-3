extends Blackboard

class_name BlackboardPlantCreature

# Blackboard for "predator" creature (no design yet)

# Poison
var has_poison: bool = true
var poison_timer: float = 0
@export var poison_timer_max: float = 30

# Food
var has_food: bool = false
var food_timer: float = 1
@export var food_timer_max: float = 30
@export var food_scene: PackedScene

func _ready() -> void:
	food_timer = food_timer_max
