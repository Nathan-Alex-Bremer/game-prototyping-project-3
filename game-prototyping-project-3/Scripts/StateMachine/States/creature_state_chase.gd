extends MonsterState
class_name CreatureStateChase

var target: Creature

func enter():
	if not blackboard:
		return
	
	if not blackboard.current_target:
		return
	
	target = blackboard.current_target

func update(_delta):
	# Expend resources
	owning_creature.change_food(_delta * -1, true)
	owning_creature.change_feisty(_delta * -1, true)
	owning_creature.change_tired(_delta * 0.21, true)
	
	if blackboard.stunned:
		Transitioned.emit(self, "creaturestatestunned")
		return
	
	if blackboard.is_pet:
		print("Got pet!")
		blackboard.current_target = null
		Transitioned.emit(self, "creaturestatepet")
		return
		
	if blackboard.is_poked:
		print("Got poked!")
		blackboard.current_target = null
		Transitioned.emit(self, "creaturestatepoke")
		return
	
	# If feisty drops below 40, return to idle
	if owning_creature.feisty < 20:
		blackboard.current_target = null # Clear reference to nonexistent object
		#TODO: Figure out a way to remove object from seen_food
		Transitioned.emit(self, "creaturestateidle")
	

func physics_update(_delta):
	if target:
		var direction = target.global_position - owning_creature.global_position
		
		if direction.length() > 80:
			owning_creature.velocity = direction.normalized() * owning_creature.move_speed * 1.2
		
		else:
			owning_creature.velocity = Vector2.ZERO
			Transitioned.emit(self, "creaturestateattack")
			return
		
		
	# If target is gone, give up on it
	else:
		blackboard.current_target = null # Clear reference to nonexistent object
		#TODO: Figure out a way to remove object from seen_food
		Transitioned.emit(self, "creaturestateidle")
	
