extends State
class_name CreatureStateEat

@export var owning_creature: Creature

func enter():
	var found_areas = %EatRadius.get_overlapping_areas()
	
	for area in found_areas:
		if area.is_in_group("food"):
			area.consume(owning_creature)
			Transitioned.emit(self, "creaturestateidle")
			break
