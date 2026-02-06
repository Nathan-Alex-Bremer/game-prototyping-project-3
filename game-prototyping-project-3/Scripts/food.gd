extends Area2D
class_name Food

var hunger_restored: float = 25
var health_restored: float = 15
var active: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func consume(eating_creature: Creature):
	if active:
		active = false
		eating_creature.change_food(hunger_restored, false)
		eating_creature.change_hit_points(health_restored)
		queue_free()
	pass
