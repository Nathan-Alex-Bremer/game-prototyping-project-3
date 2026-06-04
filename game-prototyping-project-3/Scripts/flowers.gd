extends Area2D

class_name Flowers

@export var rustle_sound: AudioStream

@export var variants: Array[Texture2D]
var base_sprite: Texture2D
@export var fire_sprite: Texture2D

var burning: bool = false
var signal_cooldown = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = variants.pick_random()
	base_sprite = $Sprite2D.texture
	$AnimationPlayer.play("on_spawn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if burning:
		signal_cooldown -= delta
		
		if signal_cooldown <= 0:
			wilt()


func wilt() -> void:
	queue_free()
	
func ignite() -> void:
	if GameState.raining:
		return
	$Sprite2D.texture = fire_sprite
	burning = true
	signal_cooldown = 5

func douse() -> void:
	if burning:
		burning = false
		signal_cooldown = 0
		$Sprite2D.texture = base_sprite
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AnimationPlayer.play("rustle_light")
		$AudioStreamPlayer2D.stream = rustle_sound
		$AudioStreamPlayer2D.pitch_scale = randf_range(0.9, 1.1) # Randomize pitch slightly
		$AudioStreamPlayer2D.play()
