extends Area2D

class_name Bush

var signal_val: StringName = ""

var signal_cooldown: float = 0
@export var signal_cooldown_max: float = 10

@export var normal_sprite: Texture2D
@export var occupied_sprite: Texture2D
@export var fire_sprite: Texture2D

var can_hide: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not can_hide:
		signal_cooldown -= delta
		
		if signal_cooldown <= 0:
			can_hide = true
			$Sprite2D.texture = normal_sprite

func get_can_hide() -> bool:
	return can_hide

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		can_hide = false
		$Sprite2D.texture = normal_sprite
		signal_cooldown = (signal_cooldown_max / 2)
	
func occupy() -> void:
	$Sprite2D.texture = occupied_sprite

func ignite() -> void:
	can_hide = false
	$Sprite2D.texture = fire_sprite
	signal_cooldown = signal_cooldown_max
