extends Creature
class_name PlantCreature

@export var poison_sprite: Sprite2D
@export var fruit_sprite: Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super._process(delta)

	if blackboard is BlackboardPlantCreature:
		poison_sprite.visible = blackboard.has_poison
		fruit_sprite.visible = blackboard.has_food
	
	if (feisty == 100) and not $VisibleOnScreenNotifier2D.is_on_screen():
		Leaving.emit(creature_name)
		
		GameState.existing_creatures.erase(self)
		GameState.num_existing_creatures -= 1
		queue_free()

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if velocity.x > 0:
		poison_sprite.flip_h = true
		fruit_sprite.flip_h = true
	elif velocity.x < 0:
		poison_sprite.flip_h = false
		fruit_sprite.flip_h = false
	# $Sprite2D.flip_h = (velocity.x > 0)
	
	if velocity.length() > 0:
		if not $WalkAudioStreamPlayer2D.playing and not is_dragging:
			$WalkAudioStreamPlayer2D.play()

func on_state_changed(new_state: MonsterState) -> void:
	super.on_state_changed(new_state)
	if blackboard is BlackboardPlantCreature:
		blackboard.dropped_food = false
