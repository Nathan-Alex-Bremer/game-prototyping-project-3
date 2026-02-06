extends Creature
class_name PlantCreature

@export var poison_sprite: Sprite2D
@export var fruit_sprite: Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)
	time_passed += delta
	# TODO: Make the labels update constantly, if you feel like it
		
	if time_passed > 5:
		# print("Hunger: " + str(hunger))
		# print("Feisty: " + str(feisty))
		# print("Tired: " + str(tired))
		time_passed = 0
	
	if blackboard is BlackboardPlantCreature:
		poison_sprite.visible = blackboard.has_poison
		fruit_sprite.visible = blackboard.has_food
	
	# Poison ticks
	if is_poisoned:
		poison_damage_timer -= delta
		if poison_damage_timer <= 0:
			poison_damage()
	
	if (hunger == 0 or hit_points == 0 or feisty == 100) and not $VisibleOnScreenNotifier2D.is_on_screen():
		Leaving.emit(creature_name)
		
		GameState.existing_creatures.erase(self)
		GameState.num_existing_creatures -= 1
		queue_free()
