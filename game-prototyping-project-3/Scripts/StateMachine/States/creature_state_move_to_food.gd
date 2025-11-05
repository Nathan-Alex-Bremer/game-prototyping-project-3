extends State
class_name CreatureStateMoveToFood

@export var owning_creature: Creature
var target: Area2D

func enter():
	if not blackboard:
		return
	
	if not blackboard.current_target:
		return
	
	target = blackboard.current_target

func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1)
	owning_creature.change_feisty(_delta * 0.48)
	owning_creature.change_tired(_delta * 0.21)

func physics_update(_delta):
	if target:
		var direction = target.global_position - owning_creature.global_position
		
		if direction.length() > 50:
			owning_creature.velocity = direction.normalized() * owning_creature.move_speed
		
		else:
			owning_creature.velocity = Vector2.ZERO
			Transitioned.emit(self, "creaturestateeat")
			return
