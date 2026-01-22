extends Action

class_name AAttackEat

@export var damage: float = 10

# Function to be implemented by Actions
func act(blackboard: Blackboard, owning_creature: Creature, owning_state: MonsterState, _delta: float) -> void:
	var found_bodies = owning_creature.eat_radius.get_overlapping_bodies()
	
	# Attack nearby creature
	# Lowers target HP, adds flag to target blackboard to make them run, sets self as target's attacker, sets self as attacking
	# Afterwards, return to chasing if feisty is still too high
	for body in found_bodies:
		if body.is_in_group("creature") and body != owning_creature:
			
			body.deal_damage(owning_creature, damage)
			blackboard.aggressive = true
			owning_creature.change_food(damage * 2, false)
			owning_creature.change_hit_points(damage / 2)
			break
