extends State
class_name CreatureStateMoveToFood

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
	
	if blackboard.is_pet:
		print("Got pet!")
		Transitioned.emit(self, "creaturestatepet")
		return
		
	if blackboard.is_poked:
		print("Got poked!")
		Transitioned.emit(self, "creaturestatepoke")
		return

func physics_update(_delta):
	if target:
		var direction = target.global_position - owning_creature.global_position
		
		if direction.length() > 50:
			owning_creature.velocity = direction.normalized() * owning_creature.move_speed
		
		else:
			owning_creature.velocity = Vector2.ZERO
			Transitioned.emit(self, "creaturestateeat")
			return
	# If food is gone, give up on it
	else:
		blackboard.current_target = null # Clear reference to nonexistent object
		#TODO: Figure out a way to remove object from seen_food
		Transitioned.emit(self, "creaturestateidle")
