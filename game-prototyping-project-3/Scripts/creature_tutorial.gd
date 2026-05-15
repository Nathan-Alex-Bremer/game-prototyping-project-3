extends Creature
class_name CreatureTutorial

# Variables

# Unique
## NEVER MIND! These can be implemented in States!

@export_group("") # Ending Sounds group

# Signals

signal spawn_complete()

# Custom functions

func spawn_animation() -> void:
	$SpawnAnimationPlayer.play("spawn") # I am dumb this should not be necessary
	# $Sprite2D.visible = true
	
func spawn_animation_complete() -> void:
	spawn_complete.emit()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "spawn":
		spawn_complete.emit()
