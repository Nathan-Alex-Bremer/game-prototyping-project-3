extends CharacterBody2D
class_name Creature

# Variables
@export var hit_points: int = 100
@export var hunger: float = 1000
@export var feisty: float = 0
@export var move_speed: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
	
