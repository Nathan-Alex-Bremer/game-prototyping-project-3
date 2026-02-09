extends Area2D
class_name Food

var hunger_restored: float = 25
var health_restored: float = 15
var active: bool = true
var lure: bool = false
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

func get_lure() -> bool:
	return lure

# Food placed down by players acts as a lure
func lure_creatures() -> void:
	var found_bodies = $LureArea2D.get_overlapping_bodies()
	for body in found_bodies:
		print("Found body")
		if body is Creature:
			# if body.get_food() < 90:
			var fruit = self
			body.send_signal("foodlure", self)
			lure = false
			
