extends State
class_name CreatureStateMoveToFood

@export var owning_creature: CharacterBody2D
var target: Area2D

func enter():
	target = get_tree().get_first_node_in_group("food")

func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1)
	owning_creature.change_feisty(_delta * 0.48)
	owning_creature.change_tired(_delta * 0.22)

func physics_update(_delta):
	if target:
		var direction = target.global_position - owning_creature.global_position
		
		if direction.length() > 50:
			owning_creature.velocity = direction.normalized() * owning_creature.move_speed
		
		else:
			owning_creature.velocity = Vector2.ZERO
			Transitioned.emit(self, "creaturestateeat")
			return
