extends CharacterBody2D
class_name Creature

# Variables
@export var hit_points: int = 100
@export var hunger: float = 100
@export var feisty: float = 0
@export var tired: float = 0
@export var move_speed: float = 10

var detect_radius = Area2D
var eat_radius = Area2D

var time_passed: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	detect_radius = $DetectRadius
	eat_radius = $EatRadius
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_passed += delta
	if time_passed > 5:
		print("Hunger: " + str(hunger))
		print("Feisty: " + str(feisty))
		print("Tired: " + str(tired))
		time_passed = 0
	

func _physics_process(delta: float) -> void:
	move_and_slide()

func change_food(amount: float) -> void:
	hunger += amount

func change_feisty(amount: float) -> void:
	feisty += amount

func change_tired(amount: float) -> void:
	tired += amount
