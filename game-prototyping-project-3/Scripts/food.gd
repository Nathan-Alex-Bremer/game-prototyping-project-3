extends Area2D
class_name Food

var hunger_restored: float = 50
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
		eating_creature.change_food(hunger_restored)
		queue_free()
	pass
